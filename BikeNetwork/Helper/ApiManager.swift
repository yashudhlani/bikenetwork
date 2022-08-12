//
//  ApiManager.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 09/08/22.
//

import Foundation

class ApiManager {
    var urlSession: URLSession?

    init(_ urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func getData<T: Codable>(_ url: URL, _ type: T.Type, onCompletion: @escaping (T) -> Void) {
        urlSession!.dataTask(with: url) { data, _, _ in
            do {
                let resultData = try JSONDecoder().decode(T.self, from: data!)
                onCompletion(resultData)
            } catch {

            }
        }.resume()
    }

}
