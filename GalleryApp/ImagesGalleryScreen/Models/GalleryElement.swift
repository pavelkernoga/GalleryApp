//
//  GalleryElement.swift
//  GalleryApp
//
//  Created by pavel on 4.03.24.
//

import UIKit

struct GalleryElement: Equatable {
    let id: String?
    let title: String?
    let description: String?
    let url: String
    var image: UIImage?
    var isLiked: Bool
}
