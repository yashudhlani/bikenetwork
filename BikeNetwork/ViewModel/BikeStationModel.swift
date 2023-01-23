//
//  StationModel.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 04/08/22.
//

import Foundation

class BikeStationModel: BikeStationModelDelagate {
    var delegate: BikeStationManagerDelegate?
    private var apiManager: ApiManagerProtocol

    init (_ apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }

    func fetchStations(_ url: URL) {
        apiManager.getData(url, NetworkInfo.self) { data, error  in
            if let error = error {
                self.delegate!.showError(error)
                return
            }
            if let data = data {
                self.delegate!.updateStations(data.network)
            }
        }
    }
}
