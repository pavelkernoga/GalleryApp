//
//  ImagesGalleryPresenter.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

class ImagesGalleryPresenter: ImagesGalleryPresenterProtocol {
    
    private var webService: ImagesGalleryWebServiceProtocol
    private weak var delegate: ImagesGalleryViewProtocol?
    
    required init(webService: ImagesGalleryWebServiceProtocol, delegate: ImagesGalleryViewProtocol) {
        self.webService = webService
        self.delegate = delegate
    }
    
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
