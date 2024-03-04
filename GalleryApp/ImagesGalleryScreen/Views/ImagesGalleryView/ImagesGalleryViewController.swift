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
    private var galleryElements: [GalleryElement] = []
    private var isPageLoading: Bool = false
    private var pageToload: Int = 1

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        showLoadingIndicator(true)
        setupPresenter()
        presenter?.showImagesGallery(pageToload)
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
    func showLoadingIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            (show) ? self.contentView.loadingView.startAnimating() : self.contentView.loadingView.stopAnimating()
        }
    }
    
    func updateCollectionView(items: [GalleryElement]) {
        if !galleryElements.isEmpty {
            for item in items {
                galleryElements.append(item)
            }
        } else {
            galleryElements = items
        }
        
        DispatchQueue.main.async {
            self.contentView.collectionView.reloadData()
            self.isPageLoading = false
            self.showLoadingIndicator(false)
        }
    }

    func showError(error: FetchError) {
        let alert = UIAlertController(title: "Error", message: "Cannot upload photos at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        DispatchQueue.main.async {
            self.showLoadingIndicator(false)
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ImagesGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGalleryCell", for: indexPath) as? ImagesGalleryCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = galleryElements[indexPath.row].image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagesDetailViewController = ImagesDetailViewController()
        imagesDetailViewController.selectedImageIndexPath = indexPath
        imagesDetailViewController.galleryElements = galleryElements
        navigationController?.pushViewController(imagesDetailViewController, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if contentView.collectionView.isScrolled(),
           !isPageLoading {
            isPageLoading = true
            pageToload = (pageToload + 1)
            presenter?.loadMoreImages(pageToload)
        }
    }
}
