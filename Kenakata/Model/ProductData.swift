//
//  ProductData.swift
//  Kenakata
//
//  Created by Md Sifat on 14/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//
import Foundation
import SwiftyJSON
struct ProductData {
    let id: Int!
    let name: String!
    let slug: String?
    let description: String!
    let price: String!
    let images: ProductImage
    let imgUrl: AnyObject!
    init(json: [String: Any]) {
        let Id = json["id"] as? Int
        let Name = json["name"] as? String
        let Slug = json["slug"] as? String
        let Description = json["description"] as? String
        let Price = json["price"] as? String
        let ImgUrl = json["images"]! as? [[String:Any]]
        //let imageDict = json["images"] as? AnyObject
        let images = ProductImage(jsonImage: ImgUrl!)

        self.id = Id
        self.name = Name
        self.slug = Slug
        self.description = Description
        self.price = Price
        self.images = images
        self.imgUrl = ImgUrl as AnyObject?

    }
    struct ProductImage {
        let id: Int!
        let src: String!
        let name: String!



        init(jsonImage: [[String:Any]]){
            let ImgId = jsonImage[0]["id"] as? Int
            let ImgName = jsonImage[0]["name"] as? String
            let ImgSrc = jsonImage[0]["src"] as? String


            self.id = ImgId
            self.name = ImgName
            self.src = ImgSrc
        }
    }
}
