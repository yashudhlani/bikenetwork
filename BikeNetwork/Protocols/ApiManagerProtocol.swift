//
//  ApiManagerProtocol.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 14/08/22.
//

import Foundation

protocol ApiManagerProtocol {
    func getData<T: Codable>(_ url: URL, _ type: T.Type, onCompletion: @escaping (T?, Error?) -> Void)

}
