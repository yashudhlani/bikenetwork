//
//  ModelProtocol.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 17/08/22.
//

import Foundation

protocol BikeNetworkModelDelegate {
    func fetchNetworks()
}

protocol BikeStationModelDelagate {
    func fetchStations(_ url: URL)
}
