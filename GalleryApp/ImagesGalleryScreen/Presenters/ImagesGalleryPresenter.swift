//
//  ImagesGalleryPresenter.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

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
        webService.fetchImages { [weak self] responseImagesModel, error in
            if let error = error {
                self?.delegate?.showError(error)
                return
            }
            
            if let responseImagesModel = responseImagesModel {
                self?.delegate?.showImages(response: responseImagesModel)
            }
        }
    }
}
