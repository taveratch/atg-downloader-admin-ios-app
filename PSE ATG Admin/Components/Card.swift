//
//  Card.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 3/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit

@IBDesignable
class Card: UIView {
    
    func initUI() {
        layer.masksToBounds = false
        layer.cornerRadius = 5
        layer.shadowColor = #colorLiteral(red: 0.8711046614, green: 0.8773157559, blue: 0.8959490395, alpha: 1)
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
}
