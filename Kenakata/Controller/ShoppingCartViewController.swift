//
//  ShoppingCartViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import Realm
import RealmSwift
import AlamofireImage

class ShoppingCartViewController: UIViewController {
    
    let realm = try! Realm()
    
    let results = try! Realm().objects(CartDataModel.self).sorted(byKeyPath: "id")
    // Save
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var shippingFeeLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var toBePaidLbl: UILabel!
    var subTotal = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.topItem?.title = "My Shopping Cart"
        addCustomItem()
        paymentCacculate()
        self.subTotalLbl.text = "৳\(subTotal)"
        self.totalLbl.text = "৳\(subTotal)"
        self.toBePaidLbl.text = "৳\(subTotal)"
        // Do any additional setup after loading the view.
    }
    func paymentCacculate(){
        for i in 0..<results.count{
            self.subTotal = subTotal +  (Int(results[i].productPrice) ?? 0 )
            
        }
        print(subTotal)
    }
    
    @IBAction func onclickCheckout(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let checkoutVC = storyboard.instantiateViewController(withIdentifier: "CheckOutViewController")
        self.navigationController?.pushViewController(checkoutVC, animated: false)
    }
    
}
extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopingCartTableViewCell
        cell.productNameTxtLbl.text = self.results[indexPath.row].productName
        cell.priceTxtLbl.text = self.results[indexPath.row].productPrice
        cell.deleteCartProductBtn.tag = self.results[indexPath.row].id
        cell.deleteCartProductBtn.addTarget(self,  action: #selector(buttonClicked), for: .touchUpInside)
        let imageUrl = self.results[indexPath.row].productImage
        Alamofire.request(imageUrl, method: .get).validate().responseImage { (responseB) in
            if let img = responseB.result.value{
                DispatchQueue.main.async {
                    cell.productImagemageView.image = img
                }
                
            }
        }
        //cell..image
        return cell
    }
    @objc func buttonClicked(_sender: UIButton) {
        self.subTotal = 0
        // delete all data from cart
        //        let realm = try! Realm()
        //          let allUploadingObjects = realm.objects(CartDataModel.self)
        //
        //          try! realm.write {
        //              realm.delete(allUploadingObjects)
        //          }
        // Delete
        if let userObject = realm.objects(CartDataModel.self).filter("id == \(_sender.tag)").first {
            print("In process of deleting")
            try! realm.write {
                realm.delete(userObject)
            }
            print("Object deleted.")
        }
        else{
            print("Object not found.")
        }
        addCustomItem()
        self.myTableView.reloadData()
        paymentCacculate()
        self.subTotalLbl.text = "৳\(subTotal)"
        self.totalLbl.text = "৳\(subTotal)"
        self.toBePaidLbl.text = "৳\(subTotal)"
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
