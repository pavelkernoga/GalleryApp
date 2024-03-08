//
//  MockCoreDataService.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import Foundation
@testable import GalleryApp

// swiftlint:disable all
final class MockImagesGalleryCoreDataService: DataProcessing {
    func saveGalleryElement(element: GalleryApp.GalleryElement, completion: @escaping (GalleryApp.CoreDataServiceError?) -> Void) {}
    
    func deleteGalleryElement(id: String, completion: @escaping (GalleryApp.CoreDataServiceError?) -> Void) {}

    func getLikedImagesIDs(idToCompare: [String], completion: @escaping ([String]?, GalleryApp.CoreDataServiceError?) -> Void) {}
}
// swiftlint:enable all
