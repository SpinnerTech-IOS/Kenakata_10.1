//
//  UserInfo.swift
//  Kenakata
//
//  Created by Md Sifat on 19/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct UserInfo {
let id: Int!
let username: String!
let nicename: String?
let description: String!
let firstname: String!
let email: String!

init(json: [String: Any]) {
    let Id = json["id"] as? Int
    let Username = json["username"] as? String
    let Nicename = json["nicename"] as? String
    let Description = json["description"] as? String
    let Firstname = json["firstname"] as? String
    let Email = json["email"]! as? String


    self.id = Id
    self.username = Username
    self.nicename = Nicename
    self.description = Description
    self.firstname = Firstname
    self.email = Email
    

    }
    
}

