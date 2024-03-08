//
//  ImagesGalleryPresenter.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

final class ImagesGalleryPresenter: ImagesGalleryPresenterProtocol {
    // MARK: - Private properties
    private var networkService: Networking
    private var coreDataService: DataProcessing
    private weak var view: ImagesGalleryViewProtocol?
    private var allGalleryElements = [GalleryElement]()
    private var likedGalleryElements = [GalleryElement]()
    private var likedElementsIDs = [String]()

    // MARK: - Initialization
    required init(networkService: Networking,
                  coreDataService: DataProcessing,
                  delegate: ImagesGalleryViewProtocol) {
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.view = delegate
    }

    // MARK: - ImagesGalleryPresenterProtocol
    func showImagesGallery(_ page: Int) {
        networkService.fetchImages(page: page) { [weak self] imagesItemsResponse, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.view?.showError(error: error)
                }
                return
            }

            if let imagesItems = imagesItemsResponse {
                self?.prepareImagesElements(with: imagesItems)
            }
        }
    }

    func loadMoreImages(_ page: Int) {
        DispatchQueue.main.async {
            self.view?.showLoadingIndicator(true)
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.showImagesGallery(page)
        }
    }

    func didUpdatelike(forIndex index: Int, withValue value: Bool) {
        allGalleryElements[index].isLiked = value
        let likedElement = allGalleryElements[index]
        if value == true {
            saveGalleryElement(element: likedElement)
        } else {
            deleteGalleryElement(element: likedElement)
        }
        self.view?.updateLike(atIndex: index, with: value)
    }

    func saveGalleryElement(element: GalleryElement) {
        coreDataService.saveGalleryElement(element: element) { error in
            if let coreDataError = error {
                self.view?.showError(error: coreDataError)
            }
        }
    }

    func deleteGalleryElement(element: GalleryElement) {
        coreDataService.deleteGalleryElement(id: element.id ?? "") { error in
            if let coreDataError = error {
                self.view?.showError(error: coreDataError)
            }
        }
    }

    func showFavoriteImagesIfNeeded() {
        if !likedGalleryElements.isEmpty {
            likedGalleryElements.removeAll()
            self.view?.update(with: allGalleryElements, likedElements: likedGalleryElements)
            return
        }
        allGalleryElements.forEach { element in
            if element.isLiked {
                likedGalleryElements.append(element)
            }
        }
        self.view?.update(with: allGalleryElements, likedElements: likedGalleryElements)
    }

    // MARK: - Private functions
    private func prepareImagesElements(with items: [ResponseImageItem]) {
        updateLikedElements(with: items, completion: { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(error: error)
                }
            }
        })
        downloadImages(for: items)
    }

    private func updateLikedElements(with items: [ResponseImageItem], completion: @escaping(CoreDataServiceError?) -> Void) {
        self.getSavedIDsFromDB(for: items, completion: { response, error in
            if error != nil {
                debugPrint("dbg: An error occured while fetching saved iDs from Core Data")
                completion(CoreDataServiceError.fetchingError)
            }
            if let savedIDs = response {
                self.likedElementsIDs = savedIDs
                completion(nil)
            }
        })
    }

    private func downloadImages(for items: [ResponseImageItem]) {
        var galleryElements = mappedGalleryElements(items: items)
        let imagesDownloadGroup = DispatchGroup()

        for item in items {
            imagesDownloadGroup.enter()
            if let url = URL(string: item.urls.regular) {
                self.networkService.getCellImage(with: url, completion: { image in
                    if let downloadedImage = image,
                       let imageIndex = galleryElements.firstIndex(where: {$0.id == item.id}) {
                        galleryElements[imageIndex].image = downloadedImage
                        imagesDownloadGroup.leave()
                    }
                })
            } else {
                imagesDownloadGroup.leave()
            }
        }
        imagesDownloadGroup.notify(queue: .global()) {
            self.performGalleryElementsUpdate(with: galleryElements)
        }
    }

    private func mappedGalleryElements(items: [ResponseImageItem]) -> [GalleryElement] {
        return items.map {
            GalleryElement(id: $0.id, title: $0.title, description: $0.description, url: $0.urls.regular, image: nil, isLiked: false)
        }
    }

    private func updateGalleryItemsWithLiked(items: [GalleryElement]) -> [GalleryElement] {
        return items.map { element in
            var updatedElement = element
            if let id = element.id, likedElementsIDs.contains(id) {
                updatedElement.isLiked = true
            }
            return updatedElement
        }
    }

    private func performGalleryElementsUpdate(with elements: [GalleryElement]) {
        if !allGalleryElements.isEmpty {
            allGalleryElements.append(contentsOf: elements)
        } else {
            allGalleryElements = elements
        }
        let updatedGalleryElements = updateGalleryItemsWithLiked(items: allGalleryElements)
        allGalleryElements = updatedGalleryElements

        DispatchQueue.main.async {
            self.view?.update(with: updatedGalleryElements, likedElements: self.likedGalleryElements)
        }
    }

    private func getSavedIDsFromDB(for items: [ResponseImageItem], completion: @escaping([String]?, CoreDataServiceError?) -> Void) {
        var loadedImagesIDs = [String]()
        items.forEach { item in
            loadedImagesIDs.append(item.id)
        }
        self.coreDataService.getLikedImagesIDs(idToCompare: loadedImagesIDs) { result, error in
            if error != nil {
                completion(nil, CoreDataServiceError.fetchingError)
            }
            completion(result, nil)
        }
    }
}
