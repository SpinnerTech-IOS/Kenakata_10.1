//
//  TopDealsViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 25/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage
import Realm
import RealmSwift


class TopDealsViewController: UIViewController{
    
    @IBOutlet var myCollectionView: UICollectionView!

    var mainTitle = "Top Deals"
    let realm = try! Realm()
    let allPrdctUrl = SingleTonManager.BASE_URL + "wp-json/wc/v2/products?&per_page=100&" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    var allProducts : [SingleProduct] = []
    var allProduct = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController?.addCustomBorderLine()
         addCustomItem()
         myCollectionView.delegate = self
         myCollectionView.dataSource = self
         self.myCollectionView.reloadData()
          navigationController!.navigationBar.topItem?.title = self.mainTitle
          navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        getJsonC()
        if let layout = myCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(myCollectionView!.bounds.width-80)/2, height: 210)
            layout.itemSize = size
            
        }
        // Do any additional setup after loading the view.
    }
    
    func getJsonC() {
        Alamofire.request(allPrdctUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    
                    for i in 0..<json.count{
                        self.allProduct.append(json[i])
                    }
                    for dic in self.allProduct{
                        let allData = SingleProduct.init(json: dic)
                        self.allProducts.append(allData)
                    }
                    print(self.allProducts.count)
                    self.myCollectionView.reloadData()
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
 

}

extension TopDealsViewController: UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! TopDealsCollectionViewCell
        //cell.imageView.image = UIImage(named: "icon-bag")
        
            cell.productNameLbl.text = self.allProducts[indexPath.row].name
            let r_price = "৳" + self.allProducts[indexPath.row].regular_price
        cell.regular_priceLbl.attributedText =  r_price.strikeThrough()
            cell.productPriceLbl.text = "৳" + self.allProducts[indexPath.row].price
            let imageUrlB = self.allProducts[indexPath.row].images.src
            cell.addCrtBtn.tag = indexPath.row
            cell.addCrtBtn.addTarget(self,  action: #selector(addToCartA), for: .touchUpInside)
            Alamofire.request(imageUrlB!, method: .get).validate().responseImage { (responseB) in
                if let img = responseB.result.value{
                    DispatchQueue.main.async {
                        cell.imgView.image = img
                    }
                    
                }
            }
        
        
        return cell
    }
    @objc func addToCartA(sender:UIButton) {
          
          let results = try! Realm().objects(CartDataModel.self).sorted(byKeyPath: "id")
          print("Test : \(Int(sender.tag))")
          var tagA = 0
          var pIdA = 0
          if results.count == 0{
              func incrementID() -> Int {
                  let realm = try! Realm()
                  return (realm.objects(CartDataModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
              }
              let realm = try! Realm()
              // Save
              let cartData = CartDataModel()
              cartData.id = incrementID()
              cartData.productId = String(self.allProducts[sender.tag].id)
              cartData.productName = self.allProducts[sender.tag].name
              cartData.productPrice = self.allProducts[sender.tag].price
              cartData.productImage = self.allProducts[sender.tag].images.src
              cartData.ProductQuantity = 1
              
              try! realm.write {
                  realm.add(cartData)
                  notifyUser(message: "Added To Cart Successfully")
                  addCustomItem()
              }
          }else{
              for i in 0..<results.count{
                  
                  if Int(results[i].productId)! == Int(self.allProducts[sender.tag].id){
                      tagA = 1
                      pIdA = Int(results[i].productId)!
                      print("Duplicate")
                      break
                  }else{
                      tagA = 2
                      print("ok")
                  }
              }
              if tagA == 1{
                  // Update
                  let objects = realm.objects(CartDataModel.self).filter("productId = %@", String(pIdA))
                  
                  if let object = objects.first {
                      try! realm.write {
                          object.ProductQuantity = object.ProductQuantity + 1
                          
                      }
                  }
                  notifyUser(message: "Added To Cart Successfully")
                  addCustomItem()
                  let cartDatas = realm.objects(CartDataModel.self)
                  for cart in cartDatas {
                      print(cart)
                  }
              } else if tagA == 2{
                  func incrementID() -> Int {
                      let realm = try! Realm()
                      return (realm.objects(CartDataModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
                  }
                  let realm = try! Realm()
                  // Save
                  let cartData = CartDataModel()
                  cartData.id = incrementID()
                  cartData.productId = String(self.allProducts[sender.tag].id)
                  cartData.productName = self.allProducts[sender.tag].name
                  cartData.productPrice = self.allProducts[sender.tag].price
                  cartData.productImage = self.allProducts[sender.tag].images.src
                  cartData.ProductQuantity = 1
                  
                  try! realm.write {
                      realm.add(cartData)
                      notifyUser(message: "Added To Cart Successfully")
                      addCustomItem()
                  }
              }else{
                  print("tag is 0")
              }
          }
          
          
          
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

