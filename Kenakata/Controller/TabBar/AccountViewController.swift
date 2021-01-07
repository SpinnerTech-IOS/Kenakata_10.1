//
//  AccountViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import Realm
class AccountViewController: UIViewController {
    let userURL = SingleTonManager.BASE_URL + "api/user/get_currentuserinfo/"
    var activityIndicator = UIActivityIndicatorView(style: .gray)
    
    @IBOutlet weak var nameTxtLbl: UILabel!
    @IBOutlet weak var emailTxtLbl: UILabel!
    @IBOutlet weak var myProfileTxtLbl: UILabel!
    let retriveCustomerUrl = SingleTonManager.BASE_URL + "/wp-json/wc/v3/customers?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    var allCustomerLists: [CustomerDataModel] = []
    var allCustomer = [[String: Any]]()
    var cID = 0
    var userEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        addMenuBtn()
        navigationController!.navigationBar.topItem?.title = "My Account"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.emailTxtLbl.text = UserDefaults.standard.string(forKey: "access_email")
        self.nameTxtLbl.text = UserDefaults.standard.string(forKey: "access_user")
        self.userEmail = UserDefaults.standard.string(forKey: "access_email") ?? "jondey@gmail.com"
        getAllCustomer()
        // Do any additional setup after loading the view.
    }
//    func getUser(){
//        let token = UserDefaults.standard.string(forKey: "access_token")
//        let params = ["cookie": token!]
//        Alamofire.request(userURL, method: .post, parameters: params as Parameters).responseJSON { response in
//            switch response.result {
//            case .success:
//                if let value = response.result.value{
//                    let data = JSON(value)
//                    self.nameTxtLbl.text = "\(data["user"]["displayname"])"
//                    self.emailTxtLbl.text = "\(data["user"]["email"])"
//                    self.userEmail = "\(data["user"]["email"])"
//                    self.getAllCustomer()
//                }
//
//            case let .failure(error):
//                print(error)
//                print("Wrong")
//            }
//
//        }
//    }
        
        
        func getAllCustomer(){
            let json = [ "email" : self.userEmail]
            print(json)
            
            
            Alamofire.request(retriveCustomerUrl, method: .get, parameters: json, encoding: URLEncoding.default, headers: nil).responseJSON { (myresponse) in
                switch myresponse.result{
                case .success:
                    // print(myresponse.result.value)
                    if let json = myresponse.result.value as? [[String: Any]] {
                        
                        for alrvew in json{
                            let allData = CustomerDataModel.init(json: alrvew)
                            self.allCustomerLists.append(allData)
                        }
                        for i in 0..<self.allCustomerLists.count{
                            
                            self.cID = self.allCustomerLists[i].id
                            print(self.allCustomerLists[i].id)
                            
                        }
                       
                    }
                    
                case let .failure(error):
                    print(error)
    
                }
            }
        }
    
    @IBAction func onClickRewards(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "RewardsViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    @IBAction func onClickSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        collectionVC?.email =  self.userEmail
        self.navigationController?.pushViewController(collectionVC!, animated: false)
    }
    
    @IBAction func onClickTransection(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "TransactionViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    @IBAction func onClickMyWallet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "MyWalletViewController")
        as? MyWalletViewController
        collectionVC?.cID =  self.cID
        self.navigationController?.pushViewController(collectionVC!, animated: false)
    }
    @IBAction func onClickProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.searchEmail = userEmail
        self.navigationController?.pushViewController(profileVC, animated: false)
    }
    @IBAction func onClickOrder(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        collectionVC?.cId =  self.cID
        self.navigationController?.pushViewController(collectionVC!, animated: false)
    }
    @IBAction func onClickGiftVoucher(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "GiftAndVoucherViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
        
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.logout()
        
    }

}
