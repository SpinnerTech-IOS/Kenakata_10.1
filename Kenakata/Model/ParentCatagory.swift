//
//  ParentCatagory.swift
//  Kenakata
//
//  Created by Md Sifat on 25/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
struct ParentCatagory {
    let id: Int!
    let name: String!
    let slug: String?
    let description: String!
    let parent: Int!
    let count: Int!
    let review_count: Int!
    let permalink : String!
    let Image: CatagoryImage
    
    init(json: [String: Any]) {
        let Id = json["id"] as? Int
        let Name = json["name"] as? String
        let Slug = json["slug"] as? String
        let Description = json["description"] as? String
        let Parent = json["parent"] as? Int
        let Count = json["count"] as? Int
        let ReviewCount = json["review_count"] as? Int
        let Permalink = json["permalink"] as? String
        let imageDict = json["image"] as? [String: Any]
        let image = CatagoryImage(json: imageDict as AnyObject )
        
        self.id = Id
        self.name = Name
        self.slug = Slug
        self.description = Description
        self.parent = Parent
        self.count  =  Count
        self.review_count = ReviewCount
        self.permalink = Permalink
        self.Image = image
        
        
    }
    struct CatagoryImage {
        let id: String!
        let src: String!
        let thumbnail: String!
        let sizes: String!
        let name: String!
        let alt: String!
        

        init(json: AnyObject?){
            let ImgId = json!["id"] as? String ?? ""
            let ImgName = json!["name"] as? String ?? ""
            let ImgSrc = json!["src"] as? String ?? ""
            let ImgThumbnail = json?["thumbnail"] as? String ?? ""
            let ImgSizes = json?["sizes"] as? String ?? ""
            let ImgAlt = json?["alt"] as? String ?? ""
            
            self.id = ImgId
            self.name = ImgName
            self.src = ImgSrc
            self.thumbnail = ImgThumbnail
            self.sizes = ImgSizes
            self.alt = ImgAlt
            
        }
    }
}
