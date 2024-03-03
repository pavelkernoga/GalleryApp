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
    func showImagesGallery() {
        delegate?.showLoadingIndicator(true)
        webService.fetchImages { [weak self] responseImagesModel, error in
            if let error = error {
                self?.delegate?.showLoadingIndicator(false)
                self?.delegate?.showError(error)
                return
            }
            
            if let responseImagesModel = responseImagesModel {
                self?.delegate?.showLoadingIndicator(false)
                self?.delegate?.showImages(response: responseImagesModel)
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
}
