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
    static let descriptionLabelColor: UIColor = .black
    static let titleFontSize: UIFont = .systemFont(ofSize: 15, weight: .bold)
    static let descriptionFontSize: UIFont = .systemFont(ofSize: 15, weight: .medium)
}

final class ImagesDetailCell: UICollectionViewCell {
    // MARK: - Private properties
    var imageTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        label.textColor = Style.cellTitleTextColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var imageDescriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        label.textColor = Style.descriptionLabelColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Style.descriptionFontSize
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        imageTitleLabel.text = nil
        imageDescriptionLabel.text = nil
        imageView.image = nil
    }
}

// MARK: - ViewSetupProtocol
extension ImagesDetailCell: ViewSetupProtocol {
    func setupHierarchy() {
        contentView.addSubviews([imageTitleLabel, imageDescriptionLabel, imageView])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            imageDescriptionLabel.topAnchor.constraint(equalTo: imageTitleLabel.bottomAnchor, constant: 20),
            imageDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageDescriptionLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
