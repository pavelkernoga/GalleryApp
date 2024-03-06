//
//  ImagesDetailViewController.swift
//  GalleryApp
//
//  Created by pavel on 4.03.24.
//

import UIKit

final class ImagesDetailViewController: UIViewController {
    // MARK: - Private properties
    private var contentView = ImagesDetailView()
    
    // MARK: - Properties
    var allGalleryElements: [GalleryElement]!
    var selectedImageIndexPath: IndexPath!
    weak var delegate: ImagesDetailViewControllerDelegate?
    
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
    
    @objc private func likeButtonTaped(sender: UIButton) {
        if let indexPath = contentView.collectionView.indexPathsForVisibleItems.first,
           let cell = contentView.collectionView.cellForItem(at: indexPath) as? ImagesDetailCell {
            cell.isLiked.toggle()
            cell.onLikeToggle?(cell.isLiked)
            delegate?.didUpdateLike(forIndex: indexPath.row, withValue: cell.isLiked)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ImagesDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allGalleryElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imagesDetailCell, for: indexPath) as? ImagesDetailCell else {
            return UICollectionViewCell()
        }
        cell.imageTitleLabel.text = allGalleryElements[indexPath.row].title
        cell.imageTitleLabel.text?.capitalizeFirstLetter()
        cell.imageDescriptionLabel.text = allGalleryElements[indexPath.row].description
        cell.imageDescriptionLabel.text?.capitalizeFirstLetter()
        cell.imageView.image = allGalleryElements[indexPath.row].image
        if allGalleryElements[indexPath.row].isLiked {
            cell.isLiked = true
        }
        cell.likeButton.addTarget(self, action: #selector(likeButtonTaped), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewFrame = collectionView.frame
        return CGSize(width: collectionViewFrame.width, height: collectionViewFrame.height)
    }
}
