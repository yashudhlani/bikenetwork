//
//  BikeStationManagerProtocol.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 17/08/22.
//

import Foundation

protocol BikeStationManagerDelegate {
    func updateStations(_ network: Network)
    func showError(_ error: Error)
}
