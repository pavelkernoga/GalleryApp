//
//  ImageDetailsCell.swift
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
    static let favoriteImage = UIImage(named: Constants.favoriteIconName)
}

final class ImageDetailsCell: UICollectionViewCell {
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

    var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(Style.favoriteImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var isLiked: Bool = false {
        didSet {
            updateFavoriteIndicator()
        }
    }

    var onLikeToggle: ((Bool) -> Void)?

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
        likeButton.imageView?.image = nil
        imageView.image = nil
        isLiked = false
    }

    // MARK: - Private functions
    @objc private func favoriteTapped() {
        isLiked.toggle()
        onLikeToggle?(isLiked)
    }

    private func updateFavoriteIndicator() {
        UIView.animate(withDuration: 0.5) {
            let imageName = self.isLiked ? Constants.favoriteSelectedIconName : Constants.favoriteIconName
            self.likeButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
}

// MARK: - ViewBuildable
extension ImageDetailsCell: ViewBuildable {
    func setupHierarchy() {
        contentView.addSubviews([imageTitleLabel, imageDescriptionLabel, imageView, likeButton])
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
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
