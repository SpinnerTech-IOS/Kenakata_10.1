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
    
    let allProductUrl = "https://afiqsouq.com/wp-json/wc/v2/products?category=707&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    let catagoriesUrl = "https://afiqsouq.com//wp-json/wc/store/products/categories?&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var parentCatagories: [ParentCatagory] = []
    var parentCatagory = [[String: Any]]()
    var allProduct : [AllProduct] = []
    var data = [[String: Any]]()
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
        getJson()
        
        navigationController?.addCustomBorderLine()
        addCustomItem()
        print(self.allProduct.count)
        
        if let layout = collectionViewA?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionViewA!.bounds.width-30)/2, height: 140)
            layout.itemSize = size
            
        }
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
            return allProduct.count
        }else if collectionView == self.collectionViewB{
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewA{
            let cell = collectionViewA.dequeueReusableCell(withReuseIdentifier: "cacell", for: indexPath) as! HomeCollectionViewACell
            return cell
        }else if collectionView == self.collectionViewB{
            let cell = collectionViewB.dequeueReusableCell(withReuseIdentifier: "cbcell", for: indexPath)
            return cell
        }
        let cell = collectionviewCatgry.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewACatCell", for: indexPath) as! HomeCollectionViewCatCell
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
                    self.collectionviewCatgry.reloadData()
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






