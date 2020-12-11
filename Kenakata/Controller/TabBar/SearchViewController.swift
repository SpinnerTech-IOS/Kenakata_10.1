//
//  SearchViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import Realm
import AlamofireImage

class SearchViewController: UIViewController {


    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    let allPrdctUrl = "https://afiqsouq.com/wp-json/wc/v2/products?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53&per_page=100"
    let realm = try! Realm()
    var allProduct : [AllProduct] = []
    var dataA = [[String: Any]]()
    var data : [String] = []
    func getData(){
        for i in 0..<allProduct.count{
             data.append(self.allProduct[i].name)
            
             self.myCollectionView.reloadData()
         }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOntap()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        addMenuBtn()
        searchBar.delegate = self
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
         self.myCollectionView.reloadData()
       navigationController!.navigationBar.topItem?.title = "Search"
       navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        print(data)
        Alamofire.request(allPrdctUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {

                    for i in 0..<json.count{
                        self.dataA.append(json[i])
                    }
                    for dic in self.dataA{
                        let allData = AllProduct.init(json: dic)
                        self.allProduct.append(allData)
                    }
                    self.getData()
                    
                    self.myCollectionView.reloadData()
                    
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
        
        if let layout = myCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(myCollectionView!.bounds.width-90)/2, height: 200)
            layout.itemSize = size
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
         getData()
         self.myCollectionView.reloadData()
    }
    
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
        //cell.imageView.image = UIImage(named: "icon-bag")
        if data[indexPath.row] == self.allProduct[indexPath.row].name{
            cell.productNameLbl.text = self.allProduct[indexPath.row].name
            cell.productPriceLbl.text = "৳" + self.allProduct[indexPath.row].price
            let imageUrlB = self.allProduct[indexPath.row].images.src
            cell.cbCartBtn.tag = indexPath.row
            cell.cbCartBtn.addTarget(self,  action: #selector(addToCartA), for: .touchUpInside)
            Alamofire.request(imageUrlB!, method: .get).validate().responseImage { (responseB) in
                if let img = responseB.result.value{
                    DispatchQueue.main.async {
                        cell.imgView.image = img
                    }
                    
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
              cartData.productId = String(self.allProduct[sender.tag].id)
              cartData.productName = self.allProduct[sender.tag].name
              cartData.productPrice = self.allProduct[sender.tag].price
              cartData.productImage = self.allProduct[sender.tag].images.src
              cartData.ProductQuantity = 1
              
              try! realm.write {
                  realm.add(cartData)
                  notifyUser(message: "Added To Cart Successfully")
                  addCustomItem()
              }
          }else{
              for i in 0..<results.count{
                  
                  if Int(results[i].productId)! == Int(self.allProduct[sender.tag].id){
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
                  cartData.productId = String(self.allProduct[sender.tag].id)
                  cartData.productName = self.allProduct[sender.tag].name
                  cartData.productPrice = self.allProduct[sender.tag].price
                  cartData.productImage = self.allProduct[sender.tag].images.src
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
        detailVC.productID = self.allProduct[indexPath.row].id
        detailVC.productsName = self.allProduct[indexPath.row].name
        detailVC.Descriptn = self.allProduct[indexPath.row].description
        detailVC.imageSrc = self.allProduct[indexPath.row].images.src
        detailVC.productPrice = self.allProduct[indexPath.row].price
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            data = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
                myCollectionView.reloadData()
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })

        myCollectionView.reloadData()
        
        
    }
    
}
