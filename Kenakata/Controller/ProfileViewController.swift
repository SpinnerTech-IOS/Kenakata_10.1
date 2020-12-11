//
//  ProfileViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var nameTxtLbl: UITextField!
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var mobileNbTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    var searchEmail = ""
    var allCustomerLists: [CustomerDataModel] = []
    var allCustomerList = [[String: Any]]()
    let retriveCustomerUrl = "https://afiqsouq.com//wp-json/wc/v3/customers?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCustomer()
        print(searchEmail)
    
        // Do any additional setup after loading the view.
    }
    
        func getAllCustomer(){
            let json = [ "email" : searchEmail]
  

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
                            self.nameTxtLbl.text  = String(self.allCustomerLists[i].username)
                            self.firstNameTxtField.text  = String(self.allCustomerLists[i].first_name)
                            self.emailTxtLbl.text  = String(self.allCustomerLists[i].email)
                            self.mobileNbTxtField.text  = String(self.allCustomerLists[i].billing.phone)
                            self.addressTxtField.text  = String(self.allCustomerLists[i].billing.address_1!)
                            self.stateTextField.text  = String(self.allCustomerLists[i].billing.state!)
                            self.countryTxtField.text  = String(self.allCustomerLists[i].billing.country!)
                            
                        }
                       // print(myresponse.result.value)
                        
                    }

                case let .failure(error):
                    print(error)
                    print("Wrong")
                }
            }
        }

}



