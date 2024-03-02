//
//  ImagesGalleryWebServiceProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

protocol ImagesGalleryWebServiceProtocol {
    func fetchImages(completion: @escaping([ImageResponseModel]?, FetchError?) -> Void)
}
