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
    private var isDataLoading: Bool = false
    private var pageToload: Int = 1

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        isDataLoading = true
        showLoadingIndicator(true)
        setupPresenter()
        presenter?.showImagesGallery(pageToload)
    }

    override func viewWillAppear(_ animated: Bool) {
        configureNavLikeButton()
        contentView.collectionView.reloadData()
    }

    // MARK: - Private functions
    private func setupPresenter() {
        if presenter == nil {
            let webService = ImagesGalleryWebService()
            let corDataService = ImagesGalleryCoreDataService()
            presenter = ImagesGalleryPresenter(webService: webService,
                                               corDataService: corDataService,
                                               delegate: self)
        }
    }

    private func configureNavLikeButton() {
        let image = UIImage(named: Constants.likedImagesIconName)
        let likeBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(presentFavoritesImages(sender:)))
        navigationItem.rightBarButtonItem = nil

        galleryElements.forEach { item in
            if item.isLiked {
                navigationItem.rightBarButtonItem = likeBarButtonItem
                return
            }
        }
    }

    @objc func presentFavoritesImages(sender: UIBarButtonItem) {
        galleryElements.forEach({ item in
            if item.isLiked {
                // TO DO:
//                presenter.showFavoritesImages()
            }
        })
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
            self.isDataLoading = false
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

    func updateLike(atIndex index: Int, with value: Bool) {
        galleryElements[index].isLiked = value
    }
}

// MARK: - ImagesDetailViewControllerDelegate
extension ImagesGalleryViewController: ImagesDetailViewControllerDelegate {
    func didUpdateLike(forIndex index: Int, withValue value: Bool) {
        presenter?.likeUpdated(forIndex: index, withValue: value)
        let likedItem = galleryElements[index]
        if value == true {
            presenter?.saveGalleryItem(item: likedItem)
            return
        }
        presenter?.deleteGalleryItem(item: likedItem)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ImagesGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imageGalleryCell, for: indexPath) as? ImagesGalleryCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = galleryElements[indexPath.row].image
        if galleryElements[indexPath.row].isLiked {
            cell.isLiked = true
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagesDetailViewController = ImagesDetailViewController()
        imagesDetailViewController.selectedImageIndexPath = indexPath
        imagesDetailViewController.galleryElements = galleryElements
        imagesDetailViewController.delegate = self
        navigationController?.pushViewController(imagesDetailViewController, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if contentView.collectionView.isScrolled(),
           !isDataLoading {
            isDataLoading = true
            pageToload = (pageToload + 1)
            presenter?.loadMoreImages(pageToload)
        }
    }
}
