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
import AlamofireImage

class CollectionViewController: UIViewController {
    
    
    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    
    var parentCatagory : [ParentCatagory] = []
    var CatagoryTitle: String?
    var catagoryID = Int()
    var allProducts : [AllProduct] = []
    var dataStore = [[String:Any]]()
    var allProductUrl = String()
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
        allProductUrl = "https://afiqsouq.com/wp-json/wc/v2/products?category=\(catagoryID)&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
        if let layout = collectionViewB?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionViewB!.bounds.width-80)/2, height: 200)
            layout.itemSize = size
            
        }
        self.collectionViewB.reloadData()
        print(allProductUrl)
        
    }
    func getCatagoryWiseProducts(){
        if let encoded = self.allProductUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
        {
        Alamofire.request(url).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    for i in 0..<json.count{
                        self.dataStore.append(json[i])
                    }
                    for dict in self.dataStore{
                        if dict["images"] != nil{
                            let allData = AllProduct.init(json: dict)
                            self.allProducts.append(allData)
                        }
                    }
                    print(self.allProducts)
                    self.collectionViewA.reloadData()
                    self.collectionViewB.reloadData()
                    print("WOWOWOW")
                    
                }
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
        
        
    }
    
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == self.collectionViewA{
            return parentCatagory.count
        }else if collectionView == self.collectionViewB{
            return self.allProducts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewB{
            let cell = collectionViewB.dequeueReusableCell(withReuseIdentifier: "cbcell", for: indexPath) as! CollectionSecondCollectionViewCell
            cell.collectionViewBTextLbl.text = self.allProducts[indexPath.row].price
            cell.collectionViewNameTextLbl.text = self.allProducts[indexPath.row].name
            let imageUrlB = self.allProducts[indexPath.row].images.name
            print("nb: \(String(describing: imageUrlB))")
            Alamofire.request(imageUrlB ?? "", method: .get).validate().responseImage { (responseB) in
                if let img = responseB.result.value{
                    DispatchQueue.main.async {
                        cell.colletionViewBImageView.image = img
                    }
                    
                }
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionCollectionViewCell
        cell.parentCatagoryName.text = self.parentCatagory[indexPath.row].name
        let imageUrl = self.parentCatagory[indexPath.row].Image.src
        if imageUrl == ""{
            cell.collectionCatagoryImageView.image = nil
        }else{
            Alamofire.request(imageUrl!, method: .get).validate().responseImage { (response) in
                if let img = response.result.value{
                    DispatchQueue.main.async {
                        cell.collectionCatagoryImageView.image = img
                    }
                    
                }
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewB{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let collectionVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            //collectionVC.parentCatagory = self.parentCatagories;
            //  collectionVC.CatagoryTitle = self.parentCatagories[indexPath.row].name
            self.navigationController?.pushViewController(collectionVC, animated: false)
            
        }
    }
}

