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
import Realm
import RealmSwift


class HomeViewController: UIViewController {
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    var imgArr = [  UIImage(named:"mobile_app_final-1"),
                    UIImage(named:"mobile_app_final-2") ,
                    UIImage(named:"mobile_app_final-3") ,
                    UIImage(named:"mobile_app_final-4") ,
                    UIImage(named:"mobile_app_final-5") ,
                    UIImage(named:"mobile_app_final-2") ]
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
    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionviewCatgry.dataSource = self
        self.collectionviewCatgry.delegate = self
        self.sliderCollectionView.dataSource = self
        self.sliderCollectionView.delegate = self
        self.collectionViewA.dataSource = self
        self.collectionViewA.delegate = self
        self.collectionViewB.dataSource = self
        self.collectionViewB.delegate = self
        //let realm = try! Realm()
        
        
        getParentCatagoryJson()
        getJsonA()
        getJsonB()
        
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        navigationController?.addCustomBorderLine()
        addCustomItem()
        addMenuBtn()
        print(self.allProductA.count)
        
        
        if let layout = sliderCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            let size = sliderCollectionView.frame.size
            //        return CGSize(width: size.width, height: size.height)
            let itmsize = CGSize(width: size.width, height: size.height)
            layout.itemSize = itmsize
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
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
        }else if collectionView == self.sliderCollectionView{
            return imgArr.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewA{
            let cell = collectionViewA.dequeueReusableCell(withReuseIdentifier: "cacell", for: indexPath) as! HomeCollectionViewACell
            cell.productNameLbl.text = self.allProductA[indexPath.row].name
            cell.productPriceLbl.text = self.allProductA[indexPath.row].price
            let imageUrlB = self.allProductA[indexPath.row].images.src
            cell.caCartBtn.tag = indexPath.row
            cell.caCartBtn.addTarget(self,  action: #selector(addToCartA), for: .touchUpInside)
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
        }else if collectionView == self.sliderCollectionView{
            let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "bnrcell", for: indexPath) as! HomeBannerCollectionViewCell
            cell.bannerImageView.image = imgArr[indexPath.row]
            cell.bannerImageView.contentMode = .scaleAspectFill
            
            cell.clipsToBounds = true
            
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
    @objc func addToCartA(sender:UIButton) {
        
        addCustomItem()
        print(sender.tag)
        func incrementID() -> Int {
            let realm = try! Realm()
            return (realm.objects(CartDataModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
        }
        let realm = try! Realm()
        // Save
        let cartData = CartDataModel()
        cartData.id = incrementID()
        cartData.productId = "\(self.allProductA[sender.tag].id)"
        cartData.productName = self.allProductA[sender.tag].name
        cartData.productPrice = self.allProductA[sender.tag].price
        cartData.productImage = self.allProductA[sender.tag].images.src
        cartData.ProductQuantity = 1
        
        try! realm.write {
            realm.add(cartData)
            notifyUser(message: "Added To Cart Successfully")
        }
        
        // Retrieve
        let cartDatas = realm.objects(CartDataModel.self)
        for cart in cartDatas {
            print(cart)
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

//extension HomeViewController: UICollectionViewDelegateFlowLayout {
//   
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = sliderCollectionView.frame.size
//        return CGSize(width: size.width, height: size.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//    
//}






