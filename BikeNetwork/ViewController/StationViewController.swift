//
//  StationViewController.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 02/08/22.
//

import UIKit

class StationViewController: UIViewController, BikeStationManagerDelegate {

    @IBOutlet weak var stationCollection: UICollectionView!

    @IBOutlet weak var networkTitle: UILabel!

    var networkName: String?
    var stationsUrl: String?
    var stationModel: BikeStationModel?
    var stations: [Station] = []
    var filteredStations: [Station] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        networkTitle.text = networkName

        stationModel = BikeStationModel(ApiManager())
        stationCollection.dataSource = self
        stationCollection.delegate = self
        stationModel!.delegate = self
        stationCollection.accessibilityIdentifier = "stationCollection_\(networkName!)"
        let url = URL(string: String("\(Contants.DOMAIN)\(stationsUrl!)"))
        stationModel!.fetchStations(url!)
        stationCollection.register(UINib(nibName: "StationViewCell", bundle: nil),
                                   forCellWithReuseIdentifier: "stationCell")
    }

    @IBAction func emptySelector(_ sender: UISegmentedControl) {
        filteredStations = sender.selectedSegmentIndex == 0 ? stations : stations.filter({ station in
            return station.emptySlots == nil ? false : station.emptySlots! != 0
        })

        stationCollection.reloadData()
    }

    func updateStations(_ network: Network) {
        DispatchQueue.main.async {
            self.stations = network.stations!
            self.filteredStations = network.stations!
            self.stationCollection.reloadData()
        }
    }

    func showError(_ error: Error) {
        var errorMessage: String?
        if let error = error as? ApiError {
            errorMessage = error.errorDescription
        } else {
            errorMessage = ApiError.networkError.errorDescription
        }
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default)
            errorAlert.addAction(ok)
            self.present(errorAlert, animated: true)
        }
    }
}

extension StationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        if let cell = self.stationCollection.dequeueReusableCell(withReuseIdentifier: "stationCell", for:
                                                                    indexPath) as? StationViewCell {
            if !filteredStations.isEmpty {
                cell.stationName.text = filteredStations[indexPath.row].name
                if let empty = filteredStations[indexPath.row].emptySlots {
                    cell.emptySlot.text = String(empty)
                } else {
                    cell.emptySlot.text = String(0)
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredStations.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.stationCollection.cellForItem(at: indexPath)
        performSegue(withIdentifier: "toStationInfo", sender: cell)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStationInfo" {
            if let cell = sender as? StationViewCell {
                if let indexPath = stationCollection.indexPath(for: cell) {
                    if let infoView = segue.destination as? StationInfoController {
                        infoView.station = stations[indexPath.row]
                        infoView.setCoordinates(stations[indexPath.row].latitude, stations[indexPath.row].latitude)
                    }
                }
            }
        }
    }

}
