//
//  calendarTableViewCell.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/17/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class calendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
