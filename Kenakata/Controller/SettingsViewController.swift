//
//  SettingsViewController.swift
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

class SettingsViewController: UIViewController {
    var email = ""
    var customerId = 0
    
    var allCustomerLists: [CustomerDataModel] = []
    var allCustomerList = [[String: Any]]()
    let retriveCustomerUrl = SingleTonManager.BASE_URL + "wp-json/wc/v3/customers?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        getAllCustomer()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClicresetPass(_ sender: Any) {
        print("touched")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "PasswordUpadateViewController") as? PasswordUpadateViewController
        collectionVC?.customerID =  self.customerId
        self.navigationController?.pushViewController(collectionVC!, animated: false)
        
    }
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.logout()
        
    }
    
    func getAllCustomer(){
        let json = [ "email" : email]
        
        
        Alamofire.request(retriveCustomerUrl, method: .get, parameters: json, encoding: URLEncoding.default, headers: nil).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                // print(myresponse.result.value)
                if let json = myresponse.result.value as? [[String: Any]] {
                    
                    for i in 0..<json.count{
                        self.allCustomerList.append(json[i])
                    }
                    
                    for alrvew in self.allCustomerList{
                        let allData = CustomerDataModel.init(json: alrvew)
                        self.allCustomerLists.append(allData)
                    }
                    for i in 0..<self.allCustomerLists.count{
                        self.customerId  = self.allCustomerLists[i].id
                        
                        
                    }
                    
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
    
    
}
