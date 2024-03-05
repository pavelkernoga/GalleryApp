//
//  ImagesGalleryDataBaseProtocol.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//

import Foundation

protocol ImagesGalleryDataBaseProtocol {
    func saveGalleryElement(element: GalleryElement) throws
    func deleteGalleryElement(id: String) throws
}
