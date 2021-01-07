//
//  CartDataModel.swift
//  Kenakata
//
//  Created by Md Sifat on 15/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CartDataModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var productId = ""
    @objc dynamic var  productName = ""
    @objc dynamic var productPrice = ""
    @objc dynamic var text = ""
    @objc dynamic var productImage = ""
    @objc dynamic var ProductQuantity = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}
