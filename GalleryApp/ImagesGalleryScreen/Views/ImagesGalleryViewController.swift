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
    private var imageItems: [ImageItem] = []

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
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
    func showLoading(_ show: Bool) {
        DispatchQueue.main.async {
            (show) ? self.contentView.loadingView.startAnimating() : self.contentView.loadingView.stopAnimating()
        }
    }

    func showImages(response: [ImageItem]) {
        imageItems = response
        DispatchQueue.main.async {
            self.contentView.collectionView.reloadData()
        }
    }

    func showError(_ error: FetchError) {
        let alert = UIAlertController(title: "Error", message: "Cannot upload photos at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ImagesGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGalleryCell", for: indexPath) as? ImagesGalleryCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
