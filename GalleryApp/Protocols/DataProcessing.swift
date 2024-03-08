//
//  CoreDataProcessing.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//

import Foundation

protocol DataProcessing {
    func saveGalleryElement(element: GalleryElement, completion: @escaping(CoreDataServiceError?) -> Void)
    func deleteGalleryElement(id: String, completion: @escaping(CoreDataServiceError?) -> Void)
    func getLikedImagesIDs(idToCompare: [String], completion: @escaping([String]?, CoreDataServiceError?) -> Void)
}
