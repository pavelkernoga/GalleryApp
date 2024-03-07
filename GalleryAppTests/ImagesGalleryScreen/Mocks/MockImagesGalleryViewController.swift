//
//  MockImagesGalleryViewController.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import Foundation
@testable import GalleryApp

final class MockImagesGalleryViewController: ImagesGalleryViewProtocol {
    func showLoadingIndicator(_ show: Bool) {}

    func update(with allElements: [GalleryElement], likedElements: [GalleryElement]) {}

    func showError(error: Error) {}

    func updateLike(atIndex index: Int, with value: Bool) {}
}
