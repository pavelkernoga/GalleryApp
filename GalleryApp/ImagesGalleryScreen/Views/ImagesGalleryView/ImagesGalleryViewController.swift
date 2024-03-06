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
    private var allGalleryElements: [GalleryElement] = []
    private var isDataLoading: Bool = false
    private var pageToload: Int = 1
    private var likedGalleryElements: [GalleryElement] = []

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
        likedGalleryElements.removeAll()
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
        allGalleryElements.forEach { item in
            if item.isLiked {
                navigationItem.rightBarButtonItem = likeBarButtonItem
                return
            }
        }
    }

    @objc func presentFavoritesImages(sender: UIBarButtonItem) {
        presenter?.showFavoriteImagesIfNeeded(items: allGalleryElements)
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
        if !allGalleryElements.isEmpty {
            for item in items {
                allGalleryElements.append(item)
            }
        } else {
            allGalleryElements = items
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
        allGalleryElements[index].isLiked = value
    }

    func showLikedImages(for items: [GalleryElement]) {
        likedGalleryElements = items
        DispatchQueue.main.async {
            self.contentView.collectionView.reloadData()
        }
    }

    func showAllImages() {
        likedGalleryElements.removeAll()
        DispatchQueue.main.async {
            self.contentView.collectionView.reloadData()
        }
    }
}

// MARK: - ImagesDetailViewControllerDelegate
extension ImagesGalleryViewController: ImagesDetailViewControllerDelegate {
    func didUpdateLike(forIndex index: Int, withValue value: Bool) {
        presenter?.likeUpdated(forIndex: index, withValue: value)
        let likedItem = allGalleryElements[index]
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
        if !likedGalleryElements.isEmpty {
            return likedGalleryElements.count
        }
        return allGalleryElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imageGalleryCell, for: indexPath) as? ImagesGalleryCell else {
            return UICollectionViewCell()
        }
        if !likedGalleryElements.isEmpty,
           likedGalleryElements[indexPath.row].isLiked {
            cell.isLiked = true
            cell.imageView.image = likedGalleryElements[indexPath.row].image
        } else {
            cell.imageView.image = allGalleryElements[indexPath.row].image
            if allGalleryElements[indexPath.row].isLiked {
                cell.isLiked = true
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagesDetailViewController = ImagesDetailViewController()
        imagesDetailViewController.selectedImageIndexPath = indexPath
        imagesDetailViewController.allGalleryElements = allGalleryElements
        imagesDetailViewController.delegate = self
        navigationController?.pushViewController(imagesDetailViewController, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if contentView.collectionView.isScrolled(),
           likedGalleryElements.isEmpty == true,
           !isDataLoading {
            isDataLoading = true
            pageToload = (pageToload + 1)
            presenter?.loadMoreImages(pageToload)
        }
    }
}
