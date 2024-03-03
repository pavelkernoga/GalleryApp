//
//  ImagesGalleryPresenterProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol ImagesGalleryPresenterProtocol: AnyObject {
    init(webService: ImagesGalleryWebServiceProtocol, delegate: ImagesGalleryViewProtocol)
    
    func showImagesGallery(_ page: Int)
    func getCellImage(from imageItem: ImageItem, completion: @escaping (UIImage?) -> Void)
    func loadMoreImages(_ page: Int)
}
