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
    
    let catagoriesUrl = "https://afiqsouq.com//wp-json/wc/store/products/categories?&consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    
    @IBOutlet weak var collectionView: UICollectionView!
    var parentCatagories: [ParentCatagory] = []
    var parentCatagory = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJson()
        collectionView.reloadData()
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
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    func getJson() {
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
                    print(self.parentCatagories.count)
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
}
extension CatagoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.parentCatagories.count   }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CatagoriesCollectionViewCell
        cell.catagoryNameLbl.text = self.parentCatagories[indexPath.row].name
        cell.catagoryAmountLbl.text = " "
        let imageUrl = self.parentCatagories[indexPath.row].Image.src
        print(imageUrl!)
        Alamofire.request(imageUrl ?? "", method: .get).validate().responseImage { (response) in
            print("IMA: \(response)")
            if let img = response.result.value{
                DispatchQueue.main.async {
                    cell.catagoryImageView.image = img
                }
                
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "collection") as! CollectionViewController
        collectionVC.parentCatagory = self.parentCatagories;
        collectionVC.CatagoryTitle = self.parentCatagories[indexPath.row].name
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    
}
