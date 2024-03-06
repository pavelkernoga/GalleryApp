//
//  ImagesGalleryResources.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

struct Constants {
    // MARK: - Unsplash API constants
    static let apiEndPointBaseUrl = "https://api.unsplash.com/photos/"
    static let accessToken = "?client_id=jW792e9RGStkjjFlC89ba4gYt5bo1bYXRs8sBdqZq5Q"
    static let itemsCount = "&per_page=30"
    static let pageToLoad = "&page="

    // MARK: - Core Data constants
    static let galleryDataEntityName = "GalleryDataEntity"
    static let predicateFormat = "id == %@"

    // MARK: - UICollectionViewCell constants
    static let imageGalleryCell = "ImageGalleryCell"
    static let imagesDetailCell = "ImagesDetailCell"

    // MARK: - UI elements constants
    static let navigtionBarTitle = "Gallery"
    static let favoriteIconName = "favorite_unselected"
    static let favoriteSelectedIconName = "favorite_selected"
    static let likedImagesIconName = "liked_images"
}
