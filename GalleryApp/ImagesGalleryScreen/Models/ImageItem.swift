//
//  ImageItem.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

struct ImageItem: Decodable {
    let id: String
    let description: String?
    let urls: ImageURLs
}

struct ImageURLs: Decodable {
    let full: String
    let regular: String
}
