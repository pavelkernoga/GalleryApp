//
//  ImageDetailsViewControllerDelegate.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//

import Foundation

protocol ImageDetailsViewProtocol: AnyObject {
    func didUpdateLike(forIndex index: Int, withValue value: Bool)
}
