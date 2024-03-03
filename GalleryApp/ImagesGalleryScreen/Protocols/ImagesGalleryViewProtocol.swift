//
//  ImageGalleryViewProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

protocol ImagesGalleryViewProtocol: AnyObject {
    func showLoading(_ show: Bool)
    func showImages(response: [ImageItem])
    func showError(_ error: FetchError)
}
