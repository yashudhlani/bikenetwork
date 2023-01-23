//
//  ApiManager.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 09/08/22.
//

import Foundation

class ApiManager: ApiManagerProtocol {
    let urlSession: URLSession

    init(_ urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func getData<T: Codable>(_ url: URL, _ type: T.Type, onCompletion: @escaping (T?, Error?) -> Void) {
        urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                onCompletion(nil, error)
            }

            do {
                let resultData = try JSONDecoder().decode(T.self, from: data!)
                onCompletion(resultData, nil)
            } catch {
                onCompletion(nil, ApiError.jsonParseError)
            }
        }.resume()
    }

}
