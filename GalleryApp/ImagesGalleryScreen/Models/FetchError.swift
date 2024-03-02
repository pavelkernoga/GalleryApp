//
//  FetchError.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

enum FetchError: LocalizedError {
    case invalidRequestURLString
    case failedRequest(description: String)
    case invalidResponse
    case invalidStatusCode(code: Int)
    case invalidResponseModel
    case invalidData
}
