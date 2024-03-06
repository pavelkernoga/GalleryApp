//
//  MockCoreDataService.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import Foundation
@testable import GalleryApp

// swiftlint:disable all
final class MockCoreDataService: ImagesGalleryDataBaseProtocol {

    func saveGalleryElement(element: GalleryApp.GalleryElement) throws {}
    
    func deleteGalleryElement(id: String) throws {}
}
// swiftlint:enable all
