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

    init(webService: GalleryApp.ImagesGalleryWebServiceProtocol, corDataService: GalleryApp.ImagesGalleryDataBaseProtocol, delegate: GalleryApp.ImagesGalleryViewProtocol) {}
    
    func showImagesGallery(_ page: Int) {
        showImagesGalleryCalled = true
    }
    
    func loadMoreImages(_ page: Int) {}
    
    func likeUpdated(forIndex index: Int, withValue value: Bool) {}
    
    func saveGalleryItem(item: GalleryApp.GalleryElement) {}
    
    func deleteGalleryItem(item: GalleryApp.GalleryElement) {}
    
    func showFavoriteImagesIfNeeded(items: [GalleryApp.GalleryElement]) {}
}
// swiftlint:disable all
