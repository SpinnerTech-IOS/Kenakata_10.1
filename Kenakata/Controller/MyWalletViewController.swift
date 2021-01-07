//
//  MyWalletViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 9/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import Realm
import AlamofireImage


class MyWalletViewController: UIViewController {
    
    @IBOutlet weak var balanceShowLbl: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    var walletDescription: [WalletModel] = []
    var walletDesc = [[String: Any]]()
    var cID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        navigationController?.navigationBar.topItem?.title = "My Wallet"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        print(cID)
        getCurrentBalance()
        getWalletDEatils()
        // Do any additional setup after loading the view.
    }
    
    func getCurrentBalance(){
        let curreentBalanceURL = SingleTonManager.BASE_URL + "wp-json/wp/v3/current_balance/" + String(self.cID)
        Alamofire.request(curreentBalanceURL).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                self.balanceShowLbl.text = "৳ " + (myresponse.result.value as! String)
            // print(myresponse.result.value as! String)
            case let .failure(error):
                print(error)
                
            }
        }
    }
    
    func getWalletDEatils() {
        let walletURL = "https://afiqsouq.com/wp-json/wp/v3/wallet/" + String(self.cID)
        Alamofire.request(walletURL).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {
                    
                    for i in 0..<json.count{
                        self.walletDesc.append(json[i])
                    }
                    for dic in self.walletDesc{
                        let allData = WalletModel.init(json: dic)
                        self.walletDescription.append(allData)
                    }
                    print(self.walletDescription)
                    
                    self.myTableView.reloadData()
                    
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
    
    
    @IBAction func topUpBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "TopUpBalanceViewController")
         self.present(collectionVC, animated: false)
    }
    
}
extension MyWalletViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.walletDescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyWalletTableViewCell
        if self.walletDescription[indexPath.row].type == "credit"{
            cell.titleLbl.text = "Balance Added"
        }else if self.walletDescription[indexPath.row].type == "debit"{
            cell.titleLbl.text = "Product Purchase"
        }
        
        cell.dateLbl.text = "on " + self.walletDescription[indexPath.row].date
        cell.nameLbl.text = self.walletDescription[indexPath.row].amount
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
