//
//  ImagesGalleryPresenterProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol ImagesGalleryPresenterProtocol: AnyObject {
    init(networkService: Networking,
         coreDataService: DataProcessing,
         delegate: ImagesGalleryViewProtocol)

    func showImagesGallery(_ page: Int)
    func loadMoreImages(_ page: Int)
    func didUpdatelike(forIndex index: Int, withValue value: Bool)
    func saveGalleryElement(element: GalleryElement)
    func deleteGalleryElement(element: GalleryElement)
    func showFavoriteImagesIfNeeded()
}
