//
//  BikeNetworkManagerProtocol.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 17/08/22.
//

import Foundation

protocol BikeNetworkManagerDelegate: AnyObject {
    func setNetwork(_ networks: [Network])
    func showError(_ error: Error)
}
