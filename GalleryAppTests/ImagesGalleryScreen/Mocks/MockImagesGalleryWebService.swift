//
//  MockImagesGalleryWebService.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import UIKit
@testable import GalleryApp

// swiftlint:disable all
final class MockImagesGalleryWebService: ImagesGalleryWebServiceProtocol {
    func fetchImages(page: Int, completion: @escaping ([GalleryApp.ResponseImageItem]?, GalleryApp.FetchError?) -> Void) {}
    
    func getCellImage(with url: URL, completion: @escaping (UIImage?) -> Void) {}
}
// swiftlint:enable all
