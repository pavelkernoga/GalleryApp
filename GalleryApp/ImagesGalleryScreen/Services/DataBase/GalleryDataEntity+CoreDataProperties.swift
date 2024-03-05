//
//  GalleryDataEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//
//

import Foundation
import CoreData

extension GalleryDataEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GalleryDataEntity> {
        return NSFetchRequest<GalleryDataEntity>(entityName: "GalleryDataEntity")
    }
    @NSManaged public var id: String
    @NSManaged public var url: String
}

extension GalleryDataEntity: Identifiable { }
