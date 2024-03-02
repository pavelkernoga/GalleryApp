//
//  ImagesGalleryViewController.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

final class ImagesGalleryViewController: UIViewController {
    // MARK: - Private properties
    private var contentView = ImagesGalleryView()
    private var presenter: ImagesGalleryPresenterProtocol?

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        setupPresenter()
        presenter?.showImagesGallery()
    }

    // MARK: - Private functions
    private func setupPresenter() {
        if presenter == nil {
            let webService = ImagesGalleryWebService()
            presenter = ImagesGalleryPresenter(webService: webService, delegate: self)
        }
    }
}

// MARK: - ImagesGalleryViewProtocol
extension ImagesGalleryViewController: ImagesGalleryViewProtocol {
    func showImages(response: [ImageItem]) {
        // TO DO: update collection according to the received model
    }

    func showError(_ error: FetchError) {
        // TO DO: show an error message to the user
    }
}
