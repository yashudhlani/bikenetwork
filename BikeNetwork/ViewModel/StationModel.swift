//
//  StationModel.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 04/08/22.
//

import Foundation

protocol StationModelUpdate {
    func updateStations(_ network: Network)
}

class StationModel {
    var delegate: StationModelUpdate?
    private var apiManager: ApiManager?

    init (_ apiManager: ApiManager) {
        self.apiManager = ApiManager()
    }

    func fetchStations(_ url: URL) {
        apiManager!.getData(url, NetworkInfo.self) { data in
            self.delegate!.updateStations(data.network)
        }
    }
}
