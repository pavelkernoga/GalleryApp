//
//  ImageDetailsViewController.swift
//  GalleryApp
//
//  Created by pavel on 4.03.24.
//

import UIKit

final class ImageDetailsViewController: UIViewController {
    // MARK: - Private properties
    private var contentView = ImageDetailsView()
    
    // MARK: - Properties
    var allGalleryElements: [GalleryElement]
    var likedGalleryElements: [GalleryElement]
    var selectedImageIndexPath: IndexPath
    weak var delegate: ImageDetailsViewProtocol?

    // MARK: - Initialization
    init(contentView: ImageDetailsView = ImageDetailsView(), allGalleryElements: [GalleryElement], likedGalleryElements: [GalleryElement], selectedImageIndexPath: IndexPath!, delegate: ImageDetailsViewProtocol? = nil) {
        self.contentView = contentView
        self.allGalleryElements = allGalleryElements
        self.likedGalleryElements = likedGalleryElements
        self.selectedImageIndexPath = selectedImageIndexPath
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ovveride
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToSelectedImage()
    }
    
    // MARK: - Private functions
    private func scrollToSelectedImage() {
        DispatchQueue.main.async {
            self.contentView.collectionView.isPagingEnabled = false
            self.contentView.collectionView.scrollToItem(at: self.selectedImageIndexPath, at: .right, animated: false)
            self.contentView.collectionView.isPagingEnabled = true
        }
    }
    
    private func configureCell(with elements: [GalleryElement], cell: ImageDetailsCell, indexPath: IndexPath) {
        cell.imageTitleLabel.text = elements[indexPath.row].title
        cell.imageTitleLabel.text?.capitalizeFirstLetter()
        cell.imageDescriptionLabel.text = elements[indexPath.row].description
        cell.imageDescriptionLabel.text?.capitalizeFirstLetter()
        cell.imageView.image = elements[indexPath.row].image
        if elements[indexPath.row].isLiked {
            cell.isLiked = true
        }
        cell.likeButton.addTarget(self, action: #selector(likeButtonTaped), for: .touchUpInside)
    }

    @objc private func likeButtonTaped(sender: UIButton) {
        if let indexPath = contentView.collectionView.indexPathsForVisibleItems.first,
           let cell = contentView.collectionView.cellForItem(at: indexPath) as? ImageDetailsCell {
            cell.isLiked.toggle()
            cell.onLikeToggle?(cell.isLiked)
            delegate?.didUpdateLike(forIndex: indexPath.row, withValue: cell.isLiked)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ImageDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !likedGalleryElements.isEmpty {
            return likedGalleryElements.count
        }
        return allGalleryElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imageDetailsCell, for: indexPath) as? ImageDetailsCell else {
            return UICollectionViewCell()
        }
        if !likedGalleryElements.isEmpty {
            configureCell(with: likedGalleryElements, cell: cell, indexPath: indexPath)
        } else {
            configureCell(with: allGalleryElements, cell: cell, indexPath: indexPath)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewFrame = collectionView.frame
        return CGSize(width: collectionViewFrame.width, height: collectionViewFrame.height)
    }
}
