//
//  AllProduct.swift
//  Kenakata
//
//  Created by Md Sifat on 27/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
struct AllProduct {
    let id: Int!
    let name: String!
    let slug: String?
    let description: String!
    let price: String!
    let images: ProductImage

    init(json: [String: Any]) {
        let Id = json["id"] as? Int
        let Name = json["name"] as? String
        let Slug = json["slug"] as? String
        let Description = json["description"] as? String
        let Price = json["price"] as? String
        let imageDict = json["images"] as? [String: Any]
        let images = ProductImage(jsonImage: imageDict)

        self.id = Id
        self.name = Name
        self.slug = Slug
        self.description = Description
        self.price = Price
        self.images = images


    }
    struct ProductImage {
        let id: Int!
        let src: String!
        let name: String!



        init(jsonImage: [String: Any]?){
            let ImgId = jsonImage?["id"] as? Int ?? 0
            let ImgName = jsonImage?["name"] as? String ?? ""
            let ImgSrc = jsonImage?["src"] as? String ?? ""


            self.id = ImgId
            self.name = ImgName
            self.src = ImgSrc
        }
    }
}
