//
//  Networking.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

protocol Networking {
    func fetchImages(page: Int, completion: @escaping([ResponseImageItem]?, FetchError?) -> Void)
    func getCellImage(with url: URL, completion: @escaping (UIImage?) -> Void)
}
