//
//  ImagesDetailView.swift
//  GalleryApp
//
//  Created by pavel on 4.03.24.
//

import UIKit

private enum Style {
    static let collectionViewBackgroundColor: UIColor = .white
}

final class ImagesDetailView: UIView {
    // MARK: - Private properties
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout() )
        view.register(ImagesGalleryCell.self, forCellWithReuseIdentifier: "ImagesGalleryCell")
        view.backgroundColor = Style.collectionViewBackgroundColor
        view.isPagingEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Private functions
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = CGSize(width: frame.width, height: frame.height)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewSetupProtocol
extension ImagesDetailView: ViewSetupProtocol {
    func setupHierarchy() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
