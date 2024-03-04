//
//  ImagesGalleryCell.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import UIKit

private enum Style {
    static let cellBackgroundColor: UIColor = .systemGray6
}

final class ImagesGalleryCell: UICollectionViewCell {
    // MARK: - Private properties
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var favoriteIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildView()
        backgroundColor = Style.cellBackgroundColor
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
            favoriteIndicatorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            favoriteIndicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteIndicatorImageView.heightAnchor.constraint(equalToConstant: 20),
            favoriteIndicatorImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
