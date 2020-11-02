//
//  WomensCollectionViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 7/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CollectionViewController: UIViewController {
    
    
    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    let allProductUrl = "https://afiqsouq.com/wp-json/wc/v2/products?category=707&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var parentCatagory : [ParentCatagory] = []
    var CatagoryTitle: String?
   var allProducts : [AllProduct] = []
    var dataStore = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCatagoryWiseProducts()
        collectionViewA.delegate = self
        collectionViewA.dataSource = self
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        navigationController?.addCustomBorderLine()
        addCustomItem()
        collectionViewA.reloadData()
        navigationController!.navigationBar.topItem?.title = CatagoryTitle
        // Do any additional setup after loading the view.
        
        print("ds: \(self.dataStore.count)")
    }
    func getCatagoryWiseProducts(){
        
        Alamofire.request(allProductUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    for i in 0..<json.count{
                        self.dataStore.append(json[i])
                    }
                    print("dfs: \(self.dataStore.count)")
                    for dic in json{
                        let allData = AllProduct.init(json: dic)
                        self.allProducts.append(allData)
                    }
                    print("uuu: \(self.allProducts.count)")
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
        
    
    }

    
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == self.collectionViewA{
            return parentCatagory.count
        }else if collectionView == self.collectionViewB{
            return 7
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewB{
            let cell = collectionViewB.dequeueReusableCell(withReuseIdentifier: "cbcell", for: indexPath) as! CollectionSecondCollectionViewCell
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionCollectionViewCell
        cell.parentCatagoryName.text = self.parentCatagory[indexPath.row].name
        let imageUrl = self.parentCatagory[indexPath.row].Image.src
        print(imageUrl!)
        Alamofire.request(imageUrl ?? "", method: .get).validate().responseImage { (response) in
            if let img = response.result.value{
                DispatchQueue.main.async {
                    cell.collectionCatagoryImageView.image = img
                }
                
            }
        }
        return cell
    }
    
    
}

