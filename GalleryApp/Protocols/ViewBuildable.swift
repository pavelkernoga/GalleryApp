//
//  ViewBuildable.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

protocol ViewBuildable {
    func setupHierarchy()
    func setupConstraints()
    func buildView()
}

extension ViewBuildable {
    func buildView() {
        setupHierarchy()
        setupConstraints()
    }
}
