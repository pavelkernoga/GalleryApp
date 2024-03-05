//
//  ImagesGalleryCoreDataService.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//

import UIKit
import CoreData

final class ImagesGalleryCoreDataService: ImagesGalleryDataBaseProtocol {
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    func saveGalleryElement(element: GalleryElement) throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.galleryDataEntityName, in: managedContext) else {
            return
        }

        createFavoriteItemEntity(entity: entity, element: element)

        do {
            try managedContext.save()
            if let entity = try fetchGalleryElement(id: element.id ?? "") {
                debugPrint("dbg: entity saved to the Core Data: \(entity)")
            }
        } catch {
            throw CoreDataError.fetchingError(message: error.localizedDescription)
        }
    }

    func deleteGalleryElement(id: String) throws {
         do {
             if let entity = try fetchGalleryElement(id: id) {
                 context?.delete(entity)
                 try? context?.save()
                 debugPrint("dbg: entity deleted from Core Data: \(entity)")
             }
         } catch {
             throw CoreDataError.deletingError(message: error.localizedDescription)
         }
     }

    private func createFavoriteItemEntity(entity: NSEntityDescription, element: GalleryElement) {
        let elementEntity = GalleryDataEntity(entity: entity, insertInto: context)
        elementEntity.id = element.id ?? ""
        elementEntity.url = element.url
    }

    private func fetchGalleryElement(id: String) throws -> GalleryDataEntity? {
        let request: NSFetchRequest<GalleryDataEntity> = GalleryDataEntity.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: Constants.predicateFormat, id)
        do {
            return try context?.fetch(request).first
        } catch {
            throw CoreDataError.fetchingError(message: error.localizedDescription)
        }
    }
}
