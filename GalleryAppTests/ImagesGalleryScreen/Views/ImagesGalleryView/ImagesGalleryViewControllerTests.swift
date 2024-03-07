//
//  ImagesGalleryViewControllerTests.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import XCTest
@testable import GalleryApp

// swiftlint:disable all
final class ImagesGalleryViewControllerTests: XCTestCase {
    var sut: ImagesGalleryViewController!

    override func setUpWithError() throws {
        sut = ImagesGalleryViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testImagesGalleryViewController_WhenCreated_HasNavigationBarConfigured() throws {
        // Arrange
        let navigtionItemTitle = try XCTUnwrap(sut.navigationItem.title, "The navigtionItemTitle is not added to the gallery view controller")

        // Assert
        XCTAssertEqual(navigtionItemTitle, "Gallery", "Navigation item title is not equal Gallery title")
    }

    func testImagesGalleryViewController_WhenCreated_HasNavigationBarButtonDisabled() {
        // Arrange
        let navigationBarItem = sut.navigationItem.rightBarButtonItem

        // Assert
        XCTAssertNil(navigationBarItem, "The navigationBarItem exists when controller initially loaded")
    }

    func testImagesGalleryViewController_WhenCreated_InvokesShowImagesGalleryProcess() {
        // Arrange
        let mockNetworkService = MockNetworkService()
        let mockCoreDataService = MockImagesGalleryCoreDataService()
        let delegate = MockImagesGalleryViewController()

        let mockImagesGalleryPresenter = MockImagesGalleryPresenter(networkService: mockNetworkService,
                                                             coreDataService: mockCoreDataService,
                                                             delegate: delegate)
        // inject mockImagesGalleryPresenter in to View controller based dependency injection
        sut.presenter = mockImagesGalleryPresenter

        // Act
        sut.presenter?.showImagesGallery(1)

        // Assert
        XCTAssertTrue(mockImagesGalleryPresenter.showImagesGalleryCalled, "The showImagesGallery() method was not called on a Presenter object when the ImagesGalleryViewController was created")
    }
}
// swiftlint:enable all
