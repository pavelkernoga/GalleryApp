//
//  ImagesDetailCell.swift
//  GalleryApp
//
//  Created by pavel on 4.03.24.
//

import UIKit

private enum Style {
    static let cellBackgroundColor: UIColor = .white
    static let cellTitleTextColor: UIColor = .black
}

final class ImagesDetailCell: UICollectionViewCell {
    // MARK: - Private properties
    var imageTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Style.cellTitleTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
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
extension ImagesDetailCell: ViewSetupProtocol {
    func setupHierarchy() {
        contentView.addSubviews([imageTitleLabel, imageView, favoriteIndicatorImageView])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageTitleLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            favoriteIndicatorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            favoriteIndicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
}
