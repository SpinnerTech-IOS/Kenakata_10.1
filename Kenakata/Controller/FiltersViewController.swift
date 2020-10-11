//
//  FiltersViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 8/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//
import UIKit

var data = [Product]()
let conditions: [(Product) -> Bool] = [
{$0.size == "L"},
{$0.catagory == "Women"},
]

class FiltersViewController: UIViewController {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    data = [Product(catagory: "Men", price: 500, color: "Red", productState: "Popular", size: "XL", brand: "Apex"), Product(catagory: "Women", price: 1000, color: "Pink", productState: "Most Popular", size: "M", brand: "Nike"),Product(catagory: "Men", price: 1000, color: "Red", productState: "Popular", size: "L", brand: "Bata"), ]        // Do any additional setup after loading the view.
    }
 
    
    let filtered = data.filter {
        product in
        conditions.reduce(true) { $0 && $1(product) }
    }
  
}
    

