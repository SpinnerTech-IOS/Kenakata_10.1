//
//  ProductDetailsViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage
import Realm
import RealmSwift

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var quantityTxtLbl: UILabel!
    @IBOutlet weak var priceTxtLbl: UILabel!
    @IBOutlet weak var sub3ImageView: CustomImageView!
    @IBOutlet weak var sub2ImageView: CustomImageView!
    @IBOutlet weak var sub1ImageView: CustomImageView!
    @IBOutlet weak var mainImageView: CustomImageView!
    
    @IBOutlet weak var descriptionViewLbl: UILabel!
    let realm = try! Realm()
    var productID: Int?
    var imageSrc: String?
    var Descriptn: String?
    var productPrice: String?
    var productsName: String?
    var quantity = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quantityTxtLbl.text = String(self.quantity)
        navigationController?.addCustomBorderLine()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Product Details"
        navigationController!.navigationBar.barStyle = UIBarStyle.black
        navigationController!.navigationBar.tintColor = UIColor.white
        
        self.descriptionViewLbl.text = self.Descriptn
        self.priceTxtLbl.text = "\(self.productPrice ?? "0")৳"
        Alamofire.request(imageSrc!, method: .get).validate().responseImage { (response) in
            if let img = response.result.value{
                DispatchQueue.main.async {
                    self.mainImageView.image = img
                    self.sub1ImageView.image = img
                    self.sub2ImageView.image = img
                    self.sub3ImageView.image = img
                }
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickIncreaseQuantity(_ sender: Any) {
        
        self.quantity = self.quantity + 1
        self.quantityTxtLbl.text = String(self.quantity)
        self.priceTxtLbl.text = "\((Int(self.productPrice!) ?? 0) * self.quantity)৳"
    }
    @IBAction func onClickDeccreaseQuantity(_ sender: Any) {
       if self.quantity >= 2{
           self.quantity = self.quantity - 1
           
       }else{
           self.quantity = 1
       }
        self.quantityTxtLbl.text = String(self.quantity)
        self.priceTxtLbl.text = "\((Int(self.productPrice!) ?? 0) * self.quantity)৳"
    }
    
    @IBAction func onClickAddCart(_ sender: Any) {
        addCustomItem()
        let results = try! Realm().objects(CartDataModel.self).sorted(byKeyPath: "id")
        var tag = 0
        var pId = 0
        for i in 0..<results.count{
            
            if Int(results[i].productId)! == self.productID!{
                tag = 1
                pId = Int(results[i].productId)!
                print("Duplicate")
            }else{
                tag = 2
                print("ok")
            }
        }
        if tag == 1{
               // Update
                let objects = realm.objects(CartDataModel.self).filter("productId = %@", String(pId))
 
                if let object = objects.first {
                    try! realm.write {
                        object.ProductQuantity = object.ProductQuantity + self.quantity
                        
                    }
                }
             notifyUser(message: "Added To Cart Successfully")
        } else{
            func incrementID() -> Int {
                let realm = try! Realm()
                return (realm.objects(CartDataModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
            }
            let realm = try! Realm()
            // Save
            let cartData = CartDataModel()
            cartData.id = incrementID()
            cartData.productId = String(self.productID!)
            cartData.productName = self.productsName!
            cartData.productPrice = self.productPrice!
            cartData.productImage = self.imageSrc!
            cartData.ProductQuantity = self.quantity
            
            try! realm.write {
                realm.add(cartData)
                notifyUser(message: "Added To Cart Successfully")
            }
        }

        //
        //               if let object = objects.first {
        //                   try! realm.write {
        //                       object.text = "updatedtext"
        //                       object.title = "updatetitle"
        //                   }
        //               }

        
        // Retrieve
        let cartDatas = realm.objects(CartDataModel.self)
        for cart in cartDatas {
            print(cart)
        }
    }
    
    @IBAction func onClickReview(_ sender: Any) {
  
        //
        //               // Update
        //               let objects = realm.objects(Note.self).filter("title = %@", "Remember the milk!")
        //
        //               if let object = objects.first {
        //                   try! realm.write {
        //                       object.text = "updatedtext"
        //                       object.title = "updatetitle"
        //                   }
        //               }
        //
        //               // Delete
        //               if let userObject = realm.objects(Note.self).filter("id == 2").first {
        //                   print("In process of deleting")
        //                   try! realm.write {
        //                       realm.delete(userObject)
        //                   }
        //                   print("Object deleted.")
        //               }
        //               else{
        //                   print("Object not found.")
        //               }
        //
        //           }
        // Simple Incremental ID
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewVC = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
        reviewVC.productId = self.productID
        self.navigationController?.pushViewController(reviewVC, animated: false)
    }
    
}
