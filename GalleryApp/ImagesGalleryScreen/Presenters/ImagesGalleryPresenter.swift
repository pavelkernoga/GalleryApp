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
    private weak var delegate: ImagesGalleryViewProtocol?
    var cellImages = [UIImage]()

    // MARK: - Initialization
    required init(webService: ImagesGalleryWebServiceProtocol, delegate: ImagesGalleryViewProtocol) {
        self.webService = webService
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
            }
        }
    }

    func getCellImage(from imageItem: ImageItem, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: imageItem.urls.regular) {
            webService.getCellImage(with: url) { image in
                if let image = image {
                    completion(image)
                }
            }
        }
    }

    func loadMoreImages(_ page: Int) {
        self.delegate?.showLoadingIndicator(true)
        DispatchQueue.global(qos: .userInitiated).async {
            self.showImagesGallery(page)
        }
    }

    private func downloadImages(for items: [ImageItem]) {
        let imagesDownloadGroup = DispatchGroup()
        for item in items {
            imagesDownloadGroup.enter()
            if let url = URL(string: item.urls.regular) {
                self.webService.getCellImage(with: url, completion: { image in
                    if let image = image {
                        self.cellImages.append(image)
                        imagesDownloadGroup.leave()
                    }
                })
            }
        }

        imagesDownloadGroup.notify(queue: .global()) {
            self.delegate?.updateCollectionView(items: items, images: self.cellImages)
        }
    }
}
