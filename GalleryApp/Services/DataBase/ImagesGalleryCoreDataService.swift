//
//  ImagesGalleryCoreDataService.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//

import UIKit
import CoreData

final class ImagesGalleryCoreDataService: DataProcessing {
    // MARK: - Private properties
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - CoreDataProcessing
    func saveGalleryElement(element: GalleryElement, completion: @escaping (CoreDataServiceError?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(CoreDataServiceError.invalidAppDelegate)
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.galleryDataEntityName, in: managedContext) else {
            completion(CoreDataServiceError.invalidEntityContext)
            return
        }
        guard let id = element.id else {
            completion(CoreDataServiceError.invalidProvidedElementId)
            return
        }
        createFavoriteItemEntity(entity: entity, element: element)
        try? managedContext.save()
        fetchGalleryElement(id: id) { error, entity in
            if let fetchError = error {
                debugPrint("dbg: \(entity as GalleryDataEntity?) cannot be saved to the Core Data")
                completion(CoreDataServiceError.savingError(message: fetchError.localizedDescription))
                return
            }
            if let fetchedEntity = entity {
                debugPrint("dbg: \(fetchedEntity) successfully saved to the Core Data")
                completion(nil)
            }
        }
    }

    func deleteGalleryElement(id: String, completion: @escaping (CoreDataServiceError?) -> Void) {
        fetchGalleryElement(id: id) { [weak self] error, entity in
            if let fetchError = error {
                completion(CoreDataServiceError.deletingError(message: fetchError.localizedDescription))
                debugPrint("dbg: \(entity as GalleryDataEntity?) cannot be deleted from Core Data")
                return
            }
            if let fetchedEntity = entity {
                self?.context?.delete(fetchedEntity)
                try? self?.context?.save()
                debugPrint("dbg: \(fetchedEntity) successfully deleted from Core Data")
            }
        }
    }

    func getLikedImagesIDs(idToCompare: [String], completion: @escaping ([String]?, CoreDataServiceError?) -> Void) {
        var resultIDs = [String]()
        idToCompare.forEach { id in
            fetchGalleryElement(id: id) { error, entity in
                if error != nil {
                    completion(nil, CoreDataServiceError.fetchingError)
                }
                if let entityId = entity?.id,
                   entityId == id {
                    resultIDs.append(entityId)
                }
            }
        }
        completion(resultIDs, nil)
    }

    // MARK: - Private functions
    private func createFavoriteItemEntity(entity: NSEntityDescription, element: GalleryElement) {
        let elementEntity = GalleryDataEntity(entity: entity, insertInto: context)
        elementEntity.id = element.id ?? ""
        elementEntity.url = element.url
    }

    private func fetchGalleryElement(id: String, completion: @escaping(CoreDataServiceError?, GalleryDataEntity?) -> Void) {
        let request: NSFetchRequest<GalleryDataEntity> = GalleryDataEntity.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: Constants.predicateFormat, id)
        do {
            let entity = try context?.fetch(request).first
            completion(nil, entity)
        } catch {
            completion(CoreDataServiceError.fetchingError, nil)
        }
    }
}
