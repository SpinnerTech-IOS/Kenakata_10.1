//
//  CancelOrderViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 3/1/21.
//  Copyright © 2021 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage
import Realm
import RealmSwift


class CancelOrderViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var orderDescription: [OrderDataModel] = []
    var orderDesc = [[String: Any]]()
    var orderId = 0
    var cID = 0
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var deliverChargeLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var subTotalLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(orderId)
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        navigationController!.navigationBar.topItem?.title = "Order Details"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        // Do any additional setup after loading the view.
        getOrderDetails()
    }
    
    
    @IBAction func onclickCancelOrder(_ sender: Any) {
    }
    func getOrderDetails() {
        print("-------")
        let walletURL = "https://afiqsouq.com/wp-json/wc/v3/orders/" + String(self.orderId) + "?consumer_key=ck_174c19562ef4a473934f3cec2eeeae1900662d2e&consumer_secret=cs_799bcbd98605696b4a71eca9703f308fa5cd0dca"
        Alamofire.request(walletURL, method: .get).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                //print(myresponse.result.value)
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

extension CancelOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderDescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cancelCell", for: indexPath) as! CancelOrderTableViewCell
        cell.productNameLbl.text = "Order Id : " + String(self.orderId)
        cell.priceLbl.text = "৳ " + self.orderDescription[indexPath.row].total
        self.totalLbl.text = "৳ " + self.orderDescription[indexPath.row].total
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
