//
//  CustomerDataModel.swift
//  Kenakata
//
//  Created by Md Sifat on 10/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CustomerDataModel {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let username: String
    let avatar_url: String
    let billing: BillingModel
    let shipping: ShippingModel
    init(json: [String: Any]) {
        let Id = json["id"] as? Int
        let Email = json["email"] as? String
        let First_name = json["first_name"] as? String
        let Last_name = json["last_name"] as? String
        let Username = json["username"] as? String
        let Avatar_url = json["avatar_url"] as? String
        let billing_data = json["billing"] as? [String: Any]
        let Billing = BillingModel(json: (billing_data)! )
        let Shipping_data = json["shipping"] as? [String: Any]
        let Shipping = ShippingModel(json: (Shipping_data)! )
        
        self.id = Id!
        self.email = Email!
        self.first_name = First_name!
        self.last_name = Last_name!
        self.username = Username!
        self.avatar_url  = Avatar_url!
        self.billing = Billing
        self.shipping = Shipping
        
        
    }
    struct BillingModel {
        
        let first_name: String?
        let last_name: String?
        let company: String?
        let address_1: String?
        let address_2: String?
        let city: String?
        let state: String?
        let postcode: String?
        let country: String?
        let email: String!
        let phone: String!
        
        init(json: [String: Any]) {
            let First_name = json["first_name"] as? String
            let Last_name = json["last_name"] as? String
            let Company = json["company"] as? String
            let Address_1 = json["address_1"] as? String
            let Address_2 = json["address_2"] as? String
            let City = json["city"] as? String
            let State = json["state"] as? String
            let Postcode = json["postcode"] as? String
            let Country = json["country"] as? String
            let Email = json["email"] as? String
            let Phone = json["phone"] as? String
            
            
            self.first_name = First_name
            self.last_name = Last_name
            self.company = Company
            self.address_1  = Address_1
            self.address_2 = Address_2
            self.city = City
            self.state = State
            self.postcode = Postcode
            self.country  = Country
            self.email = Email
            self.phone = Phone
        }
    }
    struct ShippingModel {
        let first_name: String?
        let last_name: String?
        let company: String?
        let address_1: String?
        let address_2: String?
        let city: String?
        let state: String?
        let postcode: String?
        let country: String?
        
        init(json: [String: Any]) {
            let First_name = json["first_name"] as? String
            let Last_name = json["last_name"] as? String
            let Company = json["company"] as? String
            let Address_1 = json["address_1"] as? String
            let Address_2 = json["address_2"] as? String
            let City = json["city"] as? String
            let State = json["state"] as? String
            let Postcode = json["postcode"] as? String
            let Country = json["country"] as? String
            
            
            self.first_name = First_name
            self.last_name = Last_name
            self.company = Company
            self.address_1  = Address_1
            self.address_2 = Address_2
            self.city = City
            self.state = State
            self.postcode = Postcode
            self.country  = Country
           
        }
    }
}
