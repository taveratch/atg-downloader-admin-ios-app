//
//  User.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import Foundation

class User {
    var id: Int
    var name: String
    var email: String
    var privilege: Int
    var tel: String
    var active: Bool
    var verified: Bool
    
    init?(id: Int, name: String, email: String, privilege: Int, tel: String, active: Bool, verified: Bool) {
        self.id = id
        self.name = name
        self.email = email
        self.privilege = privilege
        self.tel = tel
        self.active = active
        self.verified = verified
    }
    
    func replace(user: User) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.privilege = user.privilege
        self.tel = user.tel
        self.active = user.active
        self.verified = user.verified
    }
}
