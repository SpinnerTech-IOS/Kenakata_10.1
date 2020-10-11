//
//  Product.swift
//  Kenakata
//
//  Created by Md Sifat on 10/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
class Product{
    var catagory: String?
    var price: Int?
    var color: String?
    var productState: String?
    var size: String?
    var brand: String?
    
    init(catagory: String, price: Int, color: String, productState: String, size: String, brand: String) {
        self.catagory = catagory
        self.price = price
        self.color = color
        self.productState = productState
        self.size = size
        self.brand = brand
    }
}
