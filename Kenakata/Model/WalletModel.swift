//
//  WalletModel.swift
//  Kenakata
//
//  Created by Md Sifat on 26/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct WalletModel {
let transaction_id: String!
let amount: String!
let balance: String?
let date: String!
let details: String!
let type: String!
    

init(json: [String: Any]) {
    let Transaction_id = json["transaction_id"] as? String
    let Amount = json["amount"] as? String
    let Balance = json["balance"] as? String
    let Date = json["date"] as? String
    let Details = json["details"] as? String
    let Type = json["type"] as? String

    self.transaction_id = Transaction_id
    self.amount = Amount
    self.balance = Balance
    self.date = Date
    self.details = Details
    self.type = Type

    

    }
    
}

