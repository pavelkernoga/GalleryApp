//
//  MockImagesGalleryPresenter.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import Foundation
@testable import GalleryApp

// swiftlint:disable all
final class MockImagesGalleryPresenter: ImagesGalleryPresenterProtocol {
    var showImagesGalleryCalled: Bool = false

    init(networkService: Networking, coreDataService: DataProcessing, delegate: ImagesGalleryViewProtocol) {}

    func showImagesGallery(_ page: Int) {
        showImagesGalleryCalled = true
    }
    
    func loadMoreImages(_ page: Int) {}
    
    func didUpdatelike(forIndex index: Int, withValue value: Bool) {}
    
    func saveGalleryElement(element: GalleryElement) {}

    func deleteGalleryElement(element: GalleryElement) {}

    func showFavoriteImagesIfNeeded() {}
}
// swiftlint:disable all
