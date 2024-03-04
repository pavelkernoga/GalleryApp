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
    let title: String?

    private enum CodingKeys: String, CodingKey {
          case id, description, urls
          case title = "alt_description"
      }
}

struct ImageURLs: Decodable {
    let full: String
    let regular: String
    let small: String

    private enum CodingKeys: String, CodingKey {
        case full, regular, small
    }
}
