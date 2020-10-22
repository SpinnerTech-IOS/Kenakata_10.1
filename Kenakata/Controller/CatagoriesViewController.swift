//
//  CatagoriesViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 7/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage

class CatagoriesViewController: UIViewController{
    
    let catagoriesUrl = "https://afiqsouq.com//wp-json/wc/store/products/categories?filter[parent]&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    //"https:/afiqsouq.com/wp-json/wc/v1/products"
    
    @IBOutlet weak var collectionView: UICollectionView!
    var productsCatagories = [[String: Any]]()
    var parentCatagories = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 200)
            layout.itemSize = size
            
        }
        
    }
    func fetchData() {
        Alamofire.request(catagoriesUrl, method: .get).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let value = myresponse.result.value as? [[String: Any]] {
                    self.productsCatagories = value
                    
                    for i in 0..<self.productsCatagories.count{
                        let id = self.productsCatagories[i]["parent"] as! Int
                        
                        if id == 0{
                            self.parentCatagories.append(contentsOf: [self.productsCatagories[i]])
                            print(self.parentCatagories)
                            
                        }
                    }
                    print(self.parentCatagories.count)
                    self.collectionView.reloadData()
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
}
extension CatagoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.parentCatagories.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CatagoriesCollectionViewCell
        cell.catagoryNameLbl.text = self.parentCatagories[indexPath.row]["name"] as? String
        cell.catagoryAmountLbl.text = " "
        //    guard let imageUrl = self.parentCatagories[indexPath.row]["image"] else {return}
        //  print(imageUrl)
        //        Alamofire.request(imageUrl).responseImage { (response) in
        //            if let img = response.result.value{
        //                cell.catagoryImageView.image = img
        //            }
        //        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "collection") as! CollectionViewController
        collectionVC.parentCatagory = self.parentCatagories;        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    
}
