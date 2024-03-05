//
//  CoreDataError.swift
//  GalleryApp
//
//  Created by pavel on 5.03.24.
//

import Foundation

enum CoreDataError: LocalizedError {
    case fetchingError(message: String)
    case deletingError(message: String)
}
