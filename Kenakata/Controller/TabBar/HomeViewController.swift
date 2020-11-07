//
//  HomeViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 6/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage


class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBarHome: UISearchBar!
    
    @IBOutlet weak var collectionViewA: UICollectionView!
    
    let allProductUrl = "https://afiqsouq.com/wp-json/wc/v2/products?category=707&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    let catagoriesUrl = "https://afiqsouq.com//wp-json/wc/store/products/categories?&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var parentCatagories: [ParentCatagory] = []
    var parentCatagory = [[String: Any]]()
    var allProduct : [AllProduct] = []
    var data = [[String: Any]]()
    let header = ["Features..", "New Arivals.."]
    override func viewDidLoad() {
        super.viewDidLoad()
        getParentCatagoryJson()
        getJson()
        
        navigationController?.addCustomBorderLine()
        addCustomItem()
        print(self.allProduct.count)
        
        if let layout = collectionViewA?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionViewA!.bounds.width-30)/2, height: 200)
            layout.itemSize = size
            
        }
        
    }
    
    func getParentCatagoryJson() {
        Alamofire.request(catagoriesUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    for i in 0..<json.count{
                        let id = json[i]["parent"] as! Int
                        if id == 0{
                            self.parentCatagory.append(json[i])
                        }
                    }
                    print(self.parentCatagory.count)
                    
                    for dic in self.parentCatagory {
                        if dic["image"] != nil{
                            let allData = ParentCatagory.init(json: dic)
                            self.parentCatagories.append(allData)
                        }
                    }
                    //print(self.parentCatagories)
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
    
    func getJson() {
        Alamofire.request(allProductUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    
                    for i in 0..<json.count{
                        self.data.append(json[i])
                    }
                    for dic in self.data{
                        let allData = AllProduct.init(json: dic)
                        self.allProduct.append(allData)
                    }
                    print("ffff: \(json[1]["images"] ?? "")")
                    print("ffff: \(self.allProduct[1].images)")
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewA.dequeueReusableCell(withReuseIdentifier: "cacell", for: indexPath)
        return cell
    }
    
    
}






