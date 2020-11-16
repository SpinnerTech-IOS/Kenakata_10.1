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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.topItem?.title = "My Shopping Cart"
        // Do any additional setup after loading the view.
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
        return cell
    }
     @objc func buttonClicked(_sender: UIButton) {

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
        self.myTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
