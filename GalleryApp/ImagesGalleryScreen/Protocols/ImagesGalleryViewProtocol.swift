//
//  ImageGalleryViewProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

protocol ImagesGalleryViewProtocol: AnyObject {
    func showLoadingIndicator(_ show: Bool)
    func updateCollectionView(items: [ImageItem])
    func showError(error: FetchError)
}
