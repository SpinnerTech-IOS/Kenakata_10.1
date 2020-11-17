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
    
    @IBOutlet weak var collectionviewCatgry: UICollectionView!
    @IBOutlet weak var searchBarHome: UISearchBar!
    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    
    let firstCollectnProductUrl = "https://afiqsouq.com/wp-json/wc/v2/products?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53&category=458"
    let secondCollectnProductUrl = "https://afiqsouq.com/wp-json/wc/v2/products?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53&category=707"
    let catagoriesUrl = "https://afiqsouq.com//wp-json/wc/store/products/categories?&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var parentCatagories: [ParentCatagory] = []
    var parentCatagory = [[String: Any]]()
    var allProductA : [AllProduct] = []
    var allProductB : [ProductData] = []
    var dataA = [[String: Any]]()
    var dataB = [[String: Any]]()
    let header = ["Features..", "New Arivals.."]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionviewCatgry.dataSource = self
        self.collectionviewCatgry.delegate = self
        self.collectionViewA.dataSource = self
        self.collectionViewA.delegate = self
        self.collectionViewB.dataSource = self
        self.collectionViewB.delegate = self
        getParentCatagoryJson()
        getJsonA()
        getJsonB()
        
        navigationController?.addCustomBorderLine()
        addCustomItem()
        print(self.allProductA.count)
        
  
                if let layout = collectionViewB?.collectionViewLayout as? UICollectionViewFlowLayout{
                    layout.minimumLineSpacing = 10
                    layout.minimumInteritemSpacing = 10
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                    let size = CGSize(width:(collectionViewA!.bounds.width-30)/2, height: 140)
                    layout.itemSize = size
                    
                }
        
    }
    
    @IBAction func onClickSeeMoreCatgry(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let catagoryVC = storyboard.instantiateViewController(withIdentifier: "Catagories")
        self.navigationController?.pushViewController(catagoryVC, animated: false)
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionviewCatgry{
            return parentCatagories.count
        }else if collectionView == self.collectionViewA{
            return allProductA.count
        }else if collectionView == self.collectionViewB{
            return allProductB.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewA{
            let cell = collectionViewA.dequeueReusableCell(withReuseIdentifier: "cacell", for: indexPath) as! HomeCollectionViewACell
            cell.productNameLbl.text = self.allProductA[indexPath.row].name
            cell.productPriceLbl.text = self.allProductA[indexPath.row].price
            let imageUrlB = self.allProductA[indexPath.row].images.src
            Alamofire.request(imageUrlB!, method: .get).validate().responseImage { (responseB) in
                if let img = responseB.result.value{
                    DispatchQueue.main.async {
                        cell.imgView.image = img
                    }
                    
                }
            }
            
            return cell
        }else if collectionView == self.collectionViewB{
            let cell = collectionViewB.dequeueReusableCell(withReuseIdentifier: "cbcell", for: indexPath) as! HomeCollectionViewCellB
            cell.productNameLbl.text = self.allProductB[indexPath.row].name
            cell.productPriceLbl.text = self.allProductB[indexPath.row].price
            let imageUrlB = self.allProductB[indexPath.row].images.src
            Alamofire.request(imageUrlB!, method: .get).validate().responseImage { (responseB) in
                if let img = responseB.result.value{
                    DispatchQueue.main.async {
                        cell.imgView.image = img
                    }
                    
                }
            }
            
            return cell
        }
        let cell = collectionviewCatgry.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! HomeCollectionViewCatCell
        cell.catagoryNameTxtLbl.text = parentCatagories[indexPath.row].name
        let imageUrl = self.parentCatagories[indexPath.row].Image.src
        print(imageUrl!)
        if imageUrl == ""{
            cell.catagryImgView.image = nil
        }else{
            Alamofire.request(imageUrl!, method: .get).validate().responseImage { (response) in
                
                if let img = response.result.value{
                    DispatchQueue.main.async {
                        cell.catagryImgView.image = img
                    }
                    
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewA{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            detailVC.productID = self.allProductA[indexPath.row].id
            detailVC.productsName = self.allProductA[indexPath.row].name
            detailVC.Descriptn = self.allProductA[indexPath.row].description
            detailVC.imageSrc = self.allProductA[indexPath.row].images.src
            detailVC.productPrice = self.allProductA[indexPath.row].price
            self.navigationController?.pushViewController(detailVC, animated: false)
        }else if collectionView == self.collectionViewB{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            detailVC.productID = self.allProductB[indexPath.row].id
            detailVC.productsName = self.allProductB[indexPath.row].name
            detailVC.Descriptn = self.allProductB[indexPath.row].description
            detailVC.imageSrc = self.allProductB[indexPath.row].images.src
            detailVC.productPrice = self.allProductB[indexPath.row].price
            self.navigationController?.pushViewController(detailVC, animated: false)
        }
    }
}
extension HomeViewController{
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
                    self.collectionviewCatgry.reloadData()
                    // self.collectionViewA.reloadData()
                    // self.collectionViewB.reloadData()
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
    
    func getJsonA() {
        Alamofire.request(firstCollectnProductUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    
                    for i in 0..<json.count{
                        self.dataA.append(json[i])
                    }
                    for dic in self.dataA{
                        let allData = AllProduct.init(json: dic)
                        self.allProductA.append(allData)
                    }
                    
                    self.collectionViewA.reloadData()
                    
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
    func getJsonB() {
        Alamofire.request(secondCollectnProductUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    
                    for i in 0..<json.count{
                        self.dataB.append(json[i])
                    }
                    for dic in self.dataB{
                        let allData = ProductData.init(json: dic)
                        self.allProductB.append(allData)
                    }
                    
                    self.collectionViewB.reloadData()
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
}






