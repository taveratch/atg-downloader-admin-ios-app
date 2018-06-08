//
//  UsersTableViewCell.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var verifiedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activeLabel.layer.masksToBounds = true
        verifiedLabel.layer.masksToBounds = true
        activeLabel.layer.cornerRadius = 5
        verifiedLabel.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
