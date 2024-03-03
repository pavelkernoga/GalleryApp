//
//  UIColleectionView+Extension.swift
//  GalleryApp
//
//  Created by pavel on 3.03.24.
//

import UIKit

extension UICollectionView {
    func isScrolled() -> Bool {
        if contentOffset.y >= contentSize.height - bounds.size.height {
            return true
        }
        return false
    }
}
