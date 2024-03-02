//
//  ImageResponseModel.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

struct ImagesResponse {
    let id: Int
    let description: String
    let urls: Urls
}

struct Urls {
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
