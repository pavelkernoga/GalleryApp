//
//  ImagesGalleryViewController.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

private enum Style {
    static let navigationItemTitle: String = Constants.navigtionBarTitle
    static let navigtionBarTintColor: UIColor = .black
    static let navBarLikeButtonImageName: String = Constants.likedImagesIconName
    static let errorAlertTitle: String = "Error"
    static let uploadPhotosErrorMessage: String = "Cannot upload photos at this time"
    static let dataBaseErrorMessage: String = "Oops, something went wrong"
    static let unexpectedErrorMessage: String = "An unexpected error occurred"
    static let errorAlertButtonTitle: String = "OK"
}

final class ImagesGalleryViewController: UIViewController {
    // MARK: - Private properties
    private var contentView = ImagesGalleryView()
    private var allGalleryElements = [GalleryElement]()
    private var likedGalleryElements = [GalleryElement]()
    private var isDataLoading: Bool = false
    private var pageToload: Int = 1

    // MARK: - Properties
    var presenter: ImagesGalleryPresenterProtocol?

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigtionBar()
        view = contentView
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        isDataLoading = true
        showLoadingIndicator(true)
        setupPresenter()
        presenter?.showImagesGallery(pageToload)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.likedGalleryElements.removeAll()
        DispatchQueue.main.async {
            self.configureNavLikeButton()
            self.contentView.collectionView.reloadData()
        }
    }

    // MARK: - Private functions
    private func configureNavigtionBar() {
        navigationItem.title = Style.navigationItemTitle
        navigationController?.navigationBar.tintColor = Style.navigtionBarTintColor
    }

    private func setupPresenter() {
        if presenter == nil {
            let networkService = NetworkService()
            let coreDataService = ImagesGalleryCoreDataService()
            presenter = ImagesGalleryPresenter(networkService: networkService,
                                               coreDataService: coreDataService,
                                               delegate: self)
        }
    }

    private func configureNavLikeButton() {
        let likeBarButtonItem = UIBarButtonItem(image: UIImage(named: Style.navBarLikeButtonImageName),
                                                style: .plain,
                                                target: self,
                                                action: #selector(likeButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = nil
        if allGalleryElements.contains(where: { $0.isLiked }) {
            navigationItem.rightBarButtonItem = likeBarButtonItem
        }
    }

    @objc func likeButtonTapped(sender: UIBarButtonItem) {
        presenter?.showFavoriteImagesIfNeeded()
    }

    private func setupErrorAlert(title: String, message: String, buttonTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        return alert
    }

    private func setupErrorMessage(for error: Error) -> String {
        switch error {
        case is CoreDataServiceError:
            return Style.dataBaseErrorMessage
        case is FetchError:
            return Style.uploadPhotosErrorMessage
        default:
            return Style.unexpectedErrorMessage
        }
    }
}

// MARK: - ImagesGalleryViewProtocol
extension ImagesGalleryViewController: ImagesGalleryViewProtocol {
    func showLoadingIndicator(_ show: Bool) {
        if show == true {
            self.contentView.loadingView.startAnimating()
        } else {
            self.contentView.loadingView.stopAnimating()
        }
    }

    func update(with allElements: [GalleryElement], likedElements: [GalleryElement]) {
        allGalleryElements = allElements
        likedGalleryElements = likedElements
        configureNavLikeButton()
        isDataLoading = false
        showLoadingIndicator(false)
        contentView.collectionView.reloadData()
    }

    func showError(error: Error) {
        self.showLoadingIndicator(false)
        let errorMessage = setupErrorMessage(for: error)
        let errorAlert = setupErrorAlert(title: Style.errorAlertTitle,
                                         message: errorMessage,
                                         buttonTitle: Style.errorAlertButtonTitle)
        self.present(errorAlert, animated: true)
    }

    func updateLike(atIndex index: Int, with value: Bool) {
        allGalleryElements[index].isLiked = value
    }
}

// MARK: - ImageDetailsViewControllerDelegate
extension ImagesGalleryViewController: ImageDetailsViewProtocol {
    func didUpdateLike(forIndex index: Int, withValue value: Bool) {
        presenter?.didUpdatelike(forIndex: index, withValue: value)
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
        let imagesDetailViewController = ImageDetailsViewController(allGalleryElements: allGalleryElements,
                                                                    likedGalleryElements: likedGalleryElements,
                                                                    selectedImageIndexPath: indexPath)
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
