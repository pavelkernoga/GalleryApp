//
//  ImagesGalleryWebService.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation
import UIKit

final class ImagesGalleryWebService: ImagesGalleryWebServiceProtocol {
    // MARK: - Private properties
    private var apiUrlString: String = {
        let string = Constants.apiEndPointBaseUrl + Constants.accessToken + Constants.itemsCount + Constants.pageToLoad
        return string
    }()
    
    private let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()

    private let cache = NSCache<NSString, UIImage>()
    private var responses = [URL: [(UIImage?) -> Void]]()

    // MARK: - ImagesGalleryWebServiceProtocol
    func fetchImages(page: Int, completion: @escaping ([ResponseImageItem]?, FetchError?) -> Void) {
        guard let url = URL(string: apiUrlString + String(page)) else {
            completion(nil, FetchError.invalidRequestURLString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let requestError = error {
                completion(nil, FetchError.failedRequest(description: requestError.localizedDescription))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(nil, FetchError.invalidResponse)
                return
            }
            if response.statusCode != 200 {
                completion(nil, FetchError.invalidStatusCode(code: response.statusCode))
                return
            }
            guard let data = data else {
                completion(nil, FetchError.invalidData)
                return
            }
            do {
                let imagesResponse = try JSONDecoder().decode([ResponseImageItem].self, from: data)
                completion(imagesResponse, nil)
            } catch {
                completion(nil, FetchError.invalidResponseModel)
            }
        }
        dataTask.resume()
    }

    func getCellImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            debugPrint("dbg: cell image loaded from cache: \(url.absoluteString)")
            completion(image)
        } else {
            load(with: url, completion: completion)
            debugPrint("dbg: cell image loaded from internet: \(url.absoluteString)")
        }
    }

    // MARK: - Private functions
    private func load(with url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {data, _, _ in
            if self.responses[url] != nil {
                self.responses[url]?.append(completion)
                return
            } else {
                self.responses[url] = [completion]
            }
            guard let data = data,
                  let image = UIImage(data: data),
                  let blocks = self.responses[url] else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
            }
        }
        task.resume()
    }
}
