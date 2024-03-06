//
//  ImagesGalleryViewTests.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import XCTest
@testable import GalleryApp

final class ImagesGalleryViewTests: XCTestCase {
    var sut: ImagesGalleryView!

    override func setUpWithError() throws {
        sut = ImagesGalleryView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testImagesGalleryView_WhenCreated_HasActivityIndicatorConfigured() {
        // Arrange
        let activityIndicator = sut.loadingView

        // Assert
        XCTAssertNotNil(activityIndicator, "The loadingView is not added to the ImagesGalleryView")
        XCTAssertEqual(activityIndicator.style, .medium, "The loadingView style is not medium style")
        XCTAssertEqual(activityIndicator.color, .gray, "The loadingView color is not gray color")
    }
}
