//
//  ImageGalleryViewProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol ImagesGalleryViewProtocol: AnyObject {
    func showLoadingIndicator(_ show: Bool)
    func update()
    func showError(error: Error)
    func updateLike(atIndex index: Int, with value: Bool)
}
