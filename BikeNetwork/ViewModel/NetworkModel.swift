//
//  NetworkModel.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 03/08/22.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func setNetwork(_ networks: [Network])
}

class NetworkModel {
    var delegate: NetworkManagerDelegate?
    private var apiManager: ApiManager?

    init(_ apiManager: ApiManager) {
        self.apiManager = apiManager
    }

    func fetchNetworks() {
        let url = Contants.getNetworkUrl()
        apiManager!.getData(url, Networks.self) { data in
            self.delegate!.setNetwork(data.networks)
        }
    }
}
