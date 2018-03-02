//
//  UsersTableViewCell.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var uiView: UIView!
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
        
        uiView.layer.masksToBounds = false
        uiView.layer.cornerRadius = 5
        uiView.layer.shadowColor = #colorLiteral(red: 0.8900557585, green: 0.8964019769, blue: 0.9154406322, alpha: 1)
        uiView.layer.shadowOpacity = 0.7
        uiView.layer.shadowRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
