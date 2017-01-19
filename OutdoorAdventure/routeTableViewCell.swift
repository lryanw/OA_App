//
//  routeTableViewCell.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/17/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class routeTableViewCell: UITableViewCell {

    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeSetter: UILabel!
    @IBOutlet weak var routeRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
