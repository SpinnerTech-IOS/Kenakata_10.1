//
//  ProductLists.swift
//  Kenakata
//
//  Created by Md Sifat on 7/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductLists {
    var id = String()
    var name = String()
    var slug = String()
    var description = String()
    var price = String()
    var images : ProductImage?
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.slug = json["slug"].stringValue
        self.description = json["description"].stringValue
        self.price = json["price"].stringValue
        self.images = ProductImage(imgjson: json["images"])
        
        
        
    }
}

class ProductImage {
    var id = String()
    var name = String()
    var src = String()
    
    init(imgjson: JSON){
        self.id = imgjson["id"].stringValue
        self.name = imgjson["name"].stringValue
        self.src = imgjson["src"].stringValue
    }
   
}
