//
//  ImageGalleryViewProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol ImagesGalleryViewProtocol: AnyObject {
    func showLoadingIndicator(_ show: Bool)
    func updateCollectionView(items: [GalleryElement])
    func showError(error: FetchError)
    func updateLike(atIndex index: Int, with value: Bool)
    func showLikedImages(for items: [GalleryElement])
    func showAllImages()
}
