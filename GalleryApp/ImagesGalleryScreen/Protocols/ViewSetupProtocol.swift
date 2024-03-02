//
//  ViewSetupProtocol.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

protocol ViewSetupProtocol {
    func setupHierarchy()
    func setupConstraints()
    func buildView()
}

extension ViewSetupProtocol {
    func buildView() {
        setupHierarchy()
        setupConstraints()
    }
}
