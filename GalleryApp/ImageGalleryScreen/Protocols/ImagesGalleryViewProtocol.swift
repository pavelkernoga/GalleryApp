//
//  ImageGalleryViewProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

protocol ImagesGalleryViewProtocol: AnyObject {
    func showImages(response: [ImageResponseModel])
    func showError(_ error: FetchError)
}
