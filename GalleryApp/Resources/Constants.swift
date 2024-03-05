//
//  ImagesGalleryResources.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

struct Constants {
    static let apiEndPointBaseUrl = "https://api.unsplash.com/photos/"
    static let accessToken = "?client_id=jW792e9RGStkjjFlC89ba4gYt5bo1bYXRs8sBdqZq5Q"
    static let itemsCount = "&per_page=30"
    static let pageToLoad = "&page="

    static let imageGalleryCell = "ImageGalleryCell"
    static let imagesDetailCell = "ImagesDetailCell"

    static let favoriteIconName = "favorite_unselected"
    static let favoriteSelectedIconName = "favorite_selected"
}
