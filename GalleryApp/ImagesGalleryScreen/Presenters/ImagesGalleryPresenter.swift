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
                self?.delegate?.updateCollectionView(items: imagesItems)
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
            for _ in 0..<4 {
                sleep(1)
            }
            self.showImagesGallery(page)
        }
    }
}
