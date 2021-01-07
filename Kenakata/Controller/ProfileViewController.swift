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

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
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
    let retriveCustomerUrl =  SingleTonManager.BASE_URL + "wp-json/wc/v3/customers?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCustomer()
        print(searchEmail)
        
        self.firstNameTxtField.endEditing(false)
        self.lastNameTxtField.endEditing(false)
        self.nameTxtLbl.endEditing(false)
        self.emailTxtLbl.endEditing(false)
        self.mobileNbTxtField.endEditing(false)
        self.addressTxtField.endEditing(false)
        self.stateTextField.endEditing(false)
        self.countryTxtField.endEditing(false)
               
    
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



