//
//  OrderDataModel.swift
//  Kenakata
//
//  Created by Md Sifat on 3/1/21.
//  Copyright © 2021 Md Sifat. All rights reserved.
//

struct OrderDataModel {
    let id: Int!
    let status: String!
    let date_created: String?
    let total: String!
    let line_items: LineItem
    let line_item: AnyObject!
    
    
    init(json: [String: Any]) {
        let Id = json["id"] as? Int
        let Status = json["status"] as? String
        let Date_created = json["date_created"] as? String
        let Total = json["total"] as? String
        let Line_item = json["line_items"] as? [String:Any]
        let Line_items = LineItem(jsonImage: Line_item ?? ["":0])
        
        self.id = Id
        self.status = Status
        self.date_created = Date_created
        self.total = Total
        self.line_items = Line_items
        self.line_item = Line_item as AnyObject?
        
    }
    
    struct LineItem {
        let id: Int!
        let total: String!
        let name: String!



        init(jsonImage: [String:Any]){
            let Id = jsonImage["id"] as? Int
            let Name = jsonImage["name"] as? String
            let Total = jsonImage["total"] as? String


            self.id = Id
            self.name = Name
            self.total = Total
        }
    }
    
}
