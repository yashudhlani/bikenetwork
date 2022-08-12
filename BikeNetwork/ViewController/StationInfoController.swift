//
//  StationInfoController.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 05/08/22.
//

import Foundation
import UIKit
import MapKit

class StationInfoController: UIViewController {

    var map = MKMapView()
    var coordinates: CLLocationCoordinate2D?
    var station: Station?

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationAddress: UILabel!

    @IBOutlet weak var totalSlots: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var emptySlots: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.addSubview(map)
        map.frame = mapView.bounds
        map.isZoomEnabled = true
        map.setRegion(
            MKCoordinateRegion(
                center: coordinates!,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        stationName.text = station?.name
        stationAddress.text = station?.extra.address != nil ? station?.extra.address! : station?.extra.placement!
        setSlots()
    }

    func setCoordinates(_ latitude: Double, _ longitude: Double) {
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    @IBOutlet weak var slotsFilled: UIProgressView!
    func setSlots() {
        var emp = 1, tot = 1, empty = 0, total = 0
        if let eSlots = station?.emptySlots {
            empty = eSlots
        }

        if let tSlots = station?.freeBikes {
            total = tSlots + empty
        }

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if emp <= empty {
                self.emptySlots.text = String(emp)
                emp += 1
            }
            if tot <= total {
                self.totalSlots.text = String(tot)
                tot += 1
            }

            if emp > empty && tot > total {
                timer.invalidate()
            }

        }

        slotsFilled.progress = Float(total - empty) / Float(total)
    }
}
