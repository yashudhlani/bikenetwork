//
//  StationViewCell.swift
//  BikeNetwork
//
//  Created by user225501 on 7/29/22.
//

import UIKit

class NetworkViewCell: UITableViewCell {

    @IBOutlet weak var networkName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var networkAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
