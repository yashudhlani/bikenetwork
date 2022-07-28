//
//  ViewController.swift
//  BikeNetwork
//
//  Created by user225501 on 7/28/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stationTable: UITableView!
    
    let stations = [
        "Bysykkelen", "England"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.stationTable.dataSource = self
        
        self.stationTable.register(UINib(nibName: "StationViewCell", bundle: nil), forCellReuseIdentifier: "stationCell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.stationTable.dequeueReusableCell(withIdentifier: "stationCell") as! StationViewCell
        cell.stationName.text = stations[indexPath.row]
        return cell
    }
}

