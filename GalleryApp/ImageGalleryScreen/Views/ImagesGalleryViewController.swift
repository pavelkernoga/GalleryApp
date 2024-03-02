//
//  ImagesGalleryViewController.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

final class ImagesGalleryViewController: UIViewController {

    private var contentView = ImagesGalleryView()
    private var presenter: ImagesGalleryPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        setupPresenter()
        presenter?.showImagesGallery()
    }

    private func setupPresenter() {
        if presenter == nil {
            let webService = ImageGalleryWebService()
            presenter = ImageGalleryPresenter(webService: webService, delegate: self)
        }
    }
}

extension ImagesGalleryViewController: ImagesGalleryViewProtocol {

    func showImages(response: [ImageResponseModel]) {
        // TO DO: update collection according to the received model
    }

    func showError(_ error: FetchError) {
        // TO DO: show an error message to the user
    }
}
