//
//  ImagesGalleryPresenterProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol ImagesGalleryPresenterProtocol: AnyObject {
    init(webService: ImagesGalleryWebServiceProtocol, delegate: ImagesGalleryViewProtocol)
    
    func showImagesGallery()
    func getCellImage(from imageItem: ImageItem, completion: @escaping (UIImage?) -> Void)
}
