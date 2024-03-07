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
    
    func saveGalleryElement(element: GalleryApp.GalleryElement) {}

    func deleteGalleryElement(element: GalleryApp.GalleryElement) {}
    
    func showFavoriteImagesIfNeeded(elements: [GalleryApp.GalleryElement]) {}
}
// swiftlint:disable all
