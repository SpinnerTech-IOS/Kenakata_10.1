//
//  AllProduct.swift
//  Kenakata
//
//  Created by Md Sifat on 27/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation

struct AllProduct {
    let Catagory : Productatagory
    let id: String!
    let name: String!
    let slug: String?
    let description: String!
    let Image: ProductImage
    
    init(json: [String: Any]) {
        let Id = json["id"] as? String
        let Name = json["name"] as? String
        let Slug = json["slug"] as? String
        let Description = json["description"] as? String
        let catagoryDict = json["categories"] as? [String: Any]
        let catagory = Productatagory(json: catagoryDict as AnyObject)
        let imageDict = json["images"] as? [String: Any]
        let image = ProductImage(json: imageDict as AnyObject)
        
        self.id = Id
        self.name = Name
        self.slug = Slug
        self.description = Description
        self.Image = image
        self.Catagory = catagory
    }
    
    struct Productatagory {
        let id: String!
        let name: String!
        let slug: String!
        
        init(json: AnyObject?){
            let ImgId = json!["id"] as? String ?? ""
            let ImgName = json!["name"] as? String ?? ""
            let ImgSrc = json!["slug"] as? String ?? ""
            
            self.id = ImgId
            self.name = ImgName
            self.slug = ImgSrc
            
        }
    }
    
    struct ProductImage {
        let id: String!
        let src: String!
        let name: String!
        
        init(json: AnyObject?){
            let ImgId = json!["id"] as? String ?? ""
            let ImgName = json!["name"] as? String ?? ""
            let ImgSrc = json!["src"] as? String ?? ""
            
            self.id = ImgId
            self.name = ImgName
            self.src = ImgSrc
            
        }
    }
}

