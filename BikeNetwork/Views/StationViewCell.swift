//
//  StationViewCell.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 02/08/22.
//

import UIKit

class StationViewCell: UICollectionViewCell {

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationAddress: UILabel!
    @IBOutlet weak var emptySlot: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
