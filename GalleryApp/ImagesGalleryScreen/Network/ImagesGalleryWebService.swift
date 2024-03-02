//
//  ImagesGalleryWebService.swift
//  GalleryApp
//
//  Created by pavel on 2.03.24.
//

import Foundation

final class ImagesGalleryWebService: ImagesGalleryWebServiceProtocol {
    // MARK: - Private properties
    private var apiUrlString: String = {
        let string = Constants.apiEndPointBaseUrl + Constants.accessToken + Constants.itemsCount
        return string
    }()
    
    private let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()

    // MARK: - Functions
    func fetchImages(completion: @escaping ([ImageItem]?, FetchError?) -> Void) {
        guard let url = URL(string: apiUrlString) else {
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
                let imagesResponse = try JSONDecoder().decode([ImageItem].self, from: data)
                completion(imagesResponse, nil)
            } catch {
                completion(nil, FetchError.invalidResponseModel)
            }
        }
        dataTask.resume()
    }
}
