//
//  NetworkModel.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 03/08/22.
//

import Foundation

class BikeNetworkModel: BikeNetworkModelDelegate {
    private let delegate: BikeNetworkManagerDelegate?
    private let apiManager: ApiManagerProtocol

    init(_ apiManager: ApiManagerProtocol, _ delegate: BikeNetworkManagerDelegate) {
        self.apiManager = apiManager
        self.delegate = delegate
    }

    func fetchNetworks() {
        let url = Contants.getNetworkUrl()
        apiManager.getData(url, Networks.self) { data, error in
            if let error = error {
                self.delegate?.showError(error)
                return
            }
            if let data = data {
                self.delegate?.setNetwork(data.networks)
            }
        }
    }
}
