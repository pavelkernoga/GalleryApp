//
//  CoreDataError.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//

import Foundation

enum CoreDataServiceError: LocalizedError {
    case invalidAppDelegate
    case invalidEntityContext
    case invalidProvidedElementId
    case savingError(message: String)
    case fetchingError
    case deletingError(message: String)
}
