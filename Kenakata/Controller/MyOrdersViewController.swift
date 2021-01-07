//
//  MyOrdersViewController.swift
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


class MyOrdersViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var orderDescription: [OrderDataModel] = []
    var orderDesc = [[String: Any]]()
    var cId = 0
     var orderId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        navigationController!.navigationBar.topItem?.title = "My Orders"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        // Do any additional setup after loading the view.
        getOrderDetails()
    }
    
    func getOrderDetails() {
        print("-------")
        print(String(self.cId))
        let walletURL = "https://afiqsouq.com/wp-json/wc/v3/orders?customer=" + String(self.cId) + "&consumer_key=ck_174c19562ef4a473934f3cec2eeeae1900662d2e&consumer_secret=cs_799bcbd98605696b4a71eca9703f308fa5cd0dca"
        Alamofire.request(walletURL, method: .get).responseJSON { (myresponse) in
            switch myresponse.result{
                case .success:
                    //print(myresponse.result)
                    if let json = myresponse.result.value as? [[String: Any]] {
                    
                        for i in 0..<json.count{
                            self.orderDesc.append(json[i])
                        }
                        for dic in self.orderDesc{
                            let allData = OrderDataModel.init(json: dic)
                            self.orderDescription.append(allData)
                        }
                        print(self.orderDescription)
                        
                        self.myTableView.reloadData()
                    
                    }
                
                case let .failure(error):
                    print(error)
                    print("Wrong")
            }
        }
    }
    
    
}


extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderDescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! MyOrderTableViewCell
        cell.orderId.text = "Order Id: " + String(self.orderDescription[indexPath.row].id)
        cell.orderDate.text = "placed on: " + (self.orderDescription[indexPath.row].date_created ?? "")
        cell.orderStatus.text = self.orderDescription[indexPath.row].status
        cell.orderTotal.text = "৳ " + self.orderDescription[indexPath.row].total
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let collectionVC = storyboard.instantiateViewController(withIdentifier: "CancelOrderViewController") as! CancelOrderViewController
        collectionVC.cID = self.cId
        collectionVC.orderId = self.orderDescription[indexPath.row].id
               self.navigationController?.pushViewController(collectionVC, animated: false)
    }
}

