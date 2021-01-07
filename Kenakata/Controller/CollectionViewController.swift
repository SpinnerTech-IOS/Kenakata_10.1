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
    
    //var parentCatagory : [ParentCatagory] = []
    var parentCatagories: [ParentCatagory] = []
    var parentCatagory = [[String: Any]]()
    var CatagoryTitle: String?
    var catagoryID: Int?
    var allProducts : [AllProduct] = []
    var dataStore = [[String:Any]]()
    let allProductUrl = SingleTonManager.BASE_URL + "wp-json/wc/v2/products?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    let subCatagoryUrl = SingleTonManager.BASE_URL + "wp-json/wc/store/products/categories?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.parentCatagory)
        getsubCatagry()
        getCatagoryWiseProducts()
        collectionViewA.delegate = self
        collectionViewA.dataSource = self
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        navigationController?.addCustomBorderLine()
        addCustomItem()
        collectionViewA.reloadData()
        navigationController!.navigationBar.topItem?.title = CatagoryTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // Do any additional setup after loading the view.
        
        if let layout = collectionViewB?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionViewB!.bounds.width-90)/2, height: 200)
            layout.itemSize = size
            
        }
        if let layout = collectionViewA?.collectionViewLayout as? UICollectionViewFlowLayout{
                   layout.minimumLineSpacing = 10
                   layout.minimumInteritemSpacing = 10
                   layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                   let size = CGSize(width:(collectionViewB!.bounds.width-100)/2, height: 180)
                   layout.itemSize = size
                   
               }
        self.collectionViewB.reloadData()
        
        
    }
    
    func getsubCatagry(){
            Alamofire.request(subCatagoryUrl).responseJSON { (myresponse) in
                switch myresponse.result{
                case .success:
                    if let json = myresponse.result.value as? [[String: Any]] {
                        for i in 0..<json.count{
                            let id = json[i]["parent"] as! Int
                            if id == self.catagoryID{
                                self.parentCatagory.append(json[i])
                            }
                        }
                        print(self.parentCatagory)
                        
                        for dic in self.parentCatagory {
                            if dic["image"] != nil{
                                let allData = ParentCatagory.init(json: dic)
                                self.parentCatagories.append(allData)
                            }
                            self.collectionViewA.reloadData()
                            
                        }
                        
                    }
                    
                case let .failure(error):
                    print(error)
                    print("Wrong")
                }
            }
        }
    func getCatagoryWiseProducts(){
        let params = ["category": self.catagoryID]
        Alamofire.request(allProductUrl, method: .get, parameters: params as Parameters).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    print(json)
                    for dict in json{
                        
                        if dict["images"] != nil{
                            let allData = AllProduct.init(json: dict)
                            self.allProducts.append(allData)
                        }
                        
                        
                    }
                    print(self.allProducts)
                    //                    if let data = self.allProducts[1].imgUrl as? [[String:Any]], !data.isEmpty,
                    //                       let username = data[0]["src"] as? String {
                    //                          print("uname:\(username)")
                    //                    }
                    
                    // print(self.allProducts[1].images)
                    self.collectionViewA.reloadData()
                    self.collectionViewB.reloadData()
                    
                    
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
            return self.allProducts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewB{
            let cell = collectionViewB.dequeueReusableCell(withReuseIdentifier: "cbcell", for: indexPath) as! CollectionSecondCollectionViewCell
            cell.collectionViewBTextLbl.text = "৳" + self.allProducts[indexPath.row].price
            let r_price = "৳" + self.allProducts[indexPath.row].regular_price
            cell.reg_price.attributedText =  r_price.strikeThrough()
    
            cell.collectionViewNameTextLbl.text = self.allProducts[indexPath.row].name
            let imageUrlB = self.allProducts[indexPath.row].images.src
            print("nb: \(String(describing: imageUrlB))")
            Alamofire.request(imageUrlB!, method: .get).validate().responseImage { (responseB) in
                if let img = responseB.result.value{
                    DispatchQueue.main.async {
                        cell.colletionViewBImageView.image = img
                    }
                    
                }
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionCollectionViewCell
        let txt = self.parentCatagories[indexPath.row].name
                   let txt1 = txt?.replacingOccurrences(of: "amp;", with: "")
                   let txt2 = txt1?.replacingOccurrences(of: "&#8217;", with: "")
                   let txt3 = txt2?.replacingOccurrences(of: ",", with: "")
        cell.parentCatagoryName.text = txt3
        let imageUrl = self.parentCatagories[indexPath.row].Image.src
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
            let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            detailVC.productID = self.allProducts[indexPath.row].id
            detailVC.productsName = self.allProducts[indexPath.row].name
            detailVC.Descriptn = self.allProducts[indexPath.row].description
            detailVC.imageSrc = self.allProducts[indexPath.row].images.src
            detailVC.productPrice = self.allProducts[indexPath.row].price
            self.navigationController?.pushViewController(detailVC, animated: false)
            
        }
    }
}

