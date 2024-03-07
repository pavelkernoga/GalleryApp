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
    private var networkService: Networking
    private var corDataService: DataProcessing
    private weak var view: ImagesGalleryViewProtocol?
    private var likedImageElements = [GalleryElement]()

    // MARK: - Initialization
    required init(networkService: Networking,
                  coreDataService: DataProcessing,
                  delegate: ImagesGalleryViewProtocol) {
        self.networkService = networkService
        self.corDataService = coreDataService
        self.view = delegate
    }

    // MARK: - ImagesGalleryPresenterProtocol
    func showImagesGallery(_ page: Int) {
        networkService.fetchImages(page: page) { [weak self] imagesItemsResponse, error in
            if let error = error {
                self?.view?.showError(error: error)
                return
            }

            if let imagesItems = imagesItemsResponse {
                self?.downloadImages(for: imagesItems)
                return
            }
        }
    }

    func loadMoreImages(_ page: Int) {
        self.view?.showLoadingIndicator(true)
        DispatchQueue.global(qos: .userInitiated).async {
            self.showImagesGallery(page)
        }
    }

    func likeUpdated(forIndex index: Int, withValue value: Bool) {
        self.view?.updateLike(atIndex: index, with: value)
    }

    func saveGalleryElement(element: GalleryElement) {
        corDataService.saveGalleryElement(element: element) { error in
            if let coreDataError = error {
                self.view?.showError(error: coreDataError)
            }
        }
    }

    func deleteGalleryElement(element: GalleryElement) {
        corDataService.deleteGalleryElement(id: element.id ?? "") { error in
            if let coreDataError = error {
                self.view?.showError(error: coreDataError)
            }
        }
    }

    func showFavoriteImagesIfNeeded(elements: [GalleryElement]) {
        if !likedImageElements.isEmpty {
            likedImageElements.removeAll()
            view?.showAllImages()
            return
        }
        elements.forEach { element in
            if element.isLiked {
                likedImageElements.append(element)
            }
        }
        view?.showLikedImages(for: likedImageElements)
    }

    // MARK: - Private functions
    private func downloadImages(for items: [ResponseImageItem]) {
        var galleryElements = mappedGalleryElements(items: items)
        let imagesDownloadGroup = DispatchGroup()
        for item in items {
            imagesDownloadGroup.enter()
            if let url = URL(string: item.urls.regular) {
                self.networkService.getCellImage(with: url, completion: { image in
                    if let downloadedImage = image,
                       let imageIndex = galleryElements.firstIndex(where: {$0.id == item.id}) {
                        galleryElements[imageIndex].image = downloadedImage
                        imagesDownloadGroup.leave()
                    }
                })
            }
        }
        imagesDownloadGroup.notify(queue: .global()) {
            self.view?.updateCollectionView(items: galleryElements)
        }
    }

    private func mappedGalleryElements(items: [ResponseImageItem]) -> [GalleryElement] {
        return items.map {
            GalleryElement(id: $0.id, title: $0.title, description: $0.description, url: $0.urls.regular, image: nil, isLiked: false)
        }
    }
}
