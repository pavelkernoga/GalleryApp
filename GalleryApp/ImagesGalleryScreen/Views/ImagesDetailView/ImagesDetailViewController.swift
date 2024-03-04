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
    var cellImages: [UIImage]!
    var imageItems: [ImageItem]!
    var selectedImageIndexPath: IndexPath!

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
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ImagesDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesGalleryCell", for: indexPath) as? ImagesGalleryCell else {
            return UICollectionViewCell()
        }

        cell.backgroundColor = .white
        cell.imageView.image = cellImages[indexPath.row]
        cell.imageView.contentMode = .scaleAspectFit
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewFrame = collectionView.frame
        return CGSize(width: collectionViewFrame.width, height: collectionViewFrame.height)
    }
}
