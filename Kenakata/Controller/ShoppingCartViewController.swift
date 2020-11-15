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

class ShoppingCartViewController: UIViewController {

    let realm = try! Realm()
    
    // Save
    let cartData = CartDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Retrieve
        let cartDatas = realm.objects(CartDataModel.self)
        print(cartDatas.count)

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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
