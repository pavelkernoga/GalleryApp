//
//  ImagesGalleryPresenter.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation
import UIKit

final class ImagesGalleryPresenter: ImagesGalleryPresenterProtocol {
    // MARK: - Private properties
    private var webService: ImagesGalleryWebServiceProtocol
    private var corDataService: ImagesGalleryDataBaseProtocol
    private weak var delegate: ImagesGalleryViewProtocol?

    // MARK: - Initialization
    required init(webService: ImagesGalleryWebServiceProtocol,
                  corDataService: ImagesGalleryDataBaseProtocol,
                  delegate: ImagesGalleryViewProtocol) {
        self.webService = webService
        self.corDataService = corDataService
        self.delegate = delegate
    }

    // MARK: - Functions
    func showImagesGallery(_ page: Int) {
        webService.fetchImages(page: page) { [weak self] imagesItemsResponse, error in
            if let error = error {
                self?.delegate?.showError(error: error)
                return
            }

            if let imagesItems = imagesItemsResponse {
                self?.downloadImages(for: imagesItems)
                return
            }
        }
    }

    func loadMoreImages(_ page: Int) {
        self.delegate?.showLoadingIndicator(true)
        DispatchQueue.global(qos: .userInitiated).async {
            self.showImagesGallery(page)
        }
    }

    func likeUpdated(forIndex index: Int, withValue value: Bool) {
        self.delegate?.updateLike(atIndex: index, with: value)
    }

    func saveGalleryItem(item: GalleryElement) {
        try? self.corDataService.saveGalleryElement(element: item)
    }

    private func downloadImages(for items: [ResponseImageItem]) {
        var galleryElements = mappedGalleryElements(items: items)
        let imagesDownloadGroup = DispatchGroup()

        for item in items {
            imagesDownloadGroup.enter()
            if let url = URL(string: item.urls.regular) {
                self.webService.getCellImage(with: url, completion: { image in
                    if let downloadedImage = image,
                       let imageIndex = galleryElements.firstIndex(where: {$0.id == item.id}) {
                        galleryElements[imageIndex].image = downloadedImage
                        imagesDownloadGroup.leave()
                    }
                })
            }
        }

        imagesDownloadGroup.notify(queue: .global()) {
            self.delegate?.updateCollectionView(items: galleryElements)
        }
    }

    private func mappedGalleryElements(items: [ResponseImageItem]) -> [GalleryElement] {
        return items.map {
            GalleryElement(id: $0.id, title: $0.title, description: $0.description, url: $0.urls.regular, image: nil, isLiked: false)
        }
    }
}
