//
//  ImagesGalleryPresenterProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol ImagesGalleryPresenterProtocol: AnyObject {
    init(webService: ImagesGalleryWebServiceProtocol,
         corDataService: ImagesGalleryDataBaseProtocol,
         delegate: ImagesGalleryViewProtocol)

    func showImagesGallery(_ page: Int)
    func loadMoreImages(_ page: Int)
    func likeUpdated(forIndex index: Int, withValue value: Bool)
    func saveGalleryElement(element: GalleryElement)
    func deleteGalleryElement(element: GalleryElement)
    func showFavoriteImagesIfNeeded(elements: [GalleryElement])
}
