//
//  ImagesGalleryPresenterProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

protocol ImagesGalleryPresenterProtocol: AnyObject {
    
    init(webService: ImagesGalleryWebServiceProtocol, delegate: ImagesGalleryViewProtocol)
    
    func showImagesGallery()
}
