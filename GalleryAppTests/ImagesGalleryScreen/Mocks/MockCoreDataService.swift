//
//  MockCoreDataService.swift
//  GalleryAppTests
//
//  Created by pavel on 6.03.24.
//

import Foundation
@testable import GalleryApp

final class MockCoreDataService: ImagesGalleryDataBaseProtocol {

    func saveGalleryElement(element: GalleryApp.GalleryElement) throws {}
    
    func deleteGalleryElement(id: String) throws {}
}
