//
//  ImagesGalleryCell.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

final class ImagesGalleryCell: UICollectionViewCell {
    // MARK: - Private properties
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var favoriteIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        favoriteIndicatorImageView.image = nil
    }
}

// MARK: - ViewSetupProtocol
extension ImagesGalleryCell: ViewSetupProtocol {
    func setupHierarchy() {
        contentView.addSubviews([imageView, favoriteIndicatorImageView])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            favoriteIndicatorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            favoriteIndicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
}
