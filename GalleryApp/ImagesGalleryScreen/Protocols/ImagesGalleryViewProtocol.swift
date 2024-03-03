//
//  ImageGalleryViewProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol ImagesGalleryViewProtocol: AnyObject {
    func showLoadingIndicator(_ show: Bool)
    func updateCollectionView(items: [ImageItem], images: [UIImage]?)
    func showError(error: FetchError)
}
