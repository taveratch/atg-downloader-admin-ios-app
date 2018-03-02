//
//  Api.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 2/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    
    let host = "https://atg.padungsilpa.group/_api"
    let apiManager = ApiManager()
    
    func getAuthHeader() -> [String: String] {
        return [
            "Authorization": UserController.getToken()
        ]
    }
    
    func activateUser(id: Int, isActive: Bool, notify: Bool, completion: @escaping (_ result: [String: Any]) -> Void) {
        let body: [String: Bool] = [
            "active": isActive,
            "notify_active": notify
        ]
        apiManager.fetch(url: host + "/users/\(id)/active", header: getAuthHeader(), body: body, method: "POST") {
            response -> Void in
            completion(response!)
        }
    }
    
    func getUser(id:Int, completion: @escaping (_ user: User) -> Void) {
        apiManager.fetch(url: host + "/users/\(id)", header: getAuthHeader(), body: nil, method: "GET") {
            response -> Void in
            if response!["success"]! as! Bool {
                let userJson = response!["data"]! as! [String: Any]
                completion(
                    User(id: userJson["id"]! as! Int,
                         name: userJson["name"]! as! String,
                         email: userJson["email"]! as! String,
                         privilege: userJson["privilege"]! as! Int,
                         tel: userJson["tel"]! as! String,
                         active: userJson["active"]! as! Bool,
                         verified: userJson["verified"]! as! Bool)!
                )
            }
        }
    }
}
