//
//  ReviewrModel.swift
//  Kenakata
//
//  Created by Md Sifat on 9/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct ReviewrModel {
let id: Int!
let product_id: Int!
let reviewer: String?
let reviewer_email: String!
let review: String!
let rating: Int!

init(json: [String: Any]) {
    let Id = json["id"] as? Int
    let Product_Id = json["product_id"] as? Int
    let Reviewer = json["reviewer"] as? String
    let Reviewer_email = json["reviewer_email"] as? String
    let Review = json["review"] as? String
    let Rating = json["rating"] as? Int


    self.id = Id
    self.product_id = Product_Id
    self.reviewer = Reviewer
    self.reviewer_email = Reviewer_email
    self.review = Review
    self.rating = Rating
    
    

    }
    
}

