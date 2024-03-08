//
//  MockImagesGalleryPresenter.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import UIKit
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

    func containsLikedElements() -> Bool {
        return false
    }

    func updateLike(atIndex index: Int, with value: Bool) {}

    func getCellsCount() -> Int { 
        return .zero
    }

    func configureCell(cell: GalleryApp.ImagesGalleryCell, indexPath: IndexPath) {}

    func setupDetailsViewController(for indexPath: IndexPath) -> ImageDetailsViewController {
        return UIViewController() as! ImageDetailsViewController
    }

    func likedElementsIsEmpty() -> Bool {
        return false
    }
}
// swiftlint:disable all
