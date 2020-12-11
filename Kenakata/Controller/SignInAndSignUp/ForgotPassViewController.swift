//
//  ForgotPassViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 14/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ForgotPassViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    let retriveCustomerUrl = "https://afiqsouq.com//wp-json/wc/v3/customers?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var allCustomerLists: [CustomerDataModel] = []
    var allCustomer = [[String: Any]]()
    var isMatchedEmail = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print(",,,,,,,,,,,,,,,,,,,,,,,,,")
        // Do any additional setup after loading the view.
        
    }
    

    
    @IBAction func resetPasswordBtn(_ sender: Any) {
        
            getAllCustomer()
        
    }
    func getAllCustomer(){
        let json = [ "email" : emailTextField.text!]
         let url = URL(string: retriveCustomerUrl)!
        
//        do {
//            _ = try JSONSerialization.data(withJSONObject: json, options:[])
//            var request = URLRequest(url: url)
//            //request.httpMethod = HTTPMethod.get.rawValue
            //request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            //request.httpBody = jsonData
            
//            Alamofire.request(retriveCustomerUrl!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<299).responseJSON(completionHandler: {
//                (response) in
//                switch response.result {
//                case .success(let data):
//
//                    print(data)
//                case .failure(let error):
//                    print(error)
//
//                }
//            })
//        } catch {
//            print("Failed to serialise and send JSON")
//        }

        Alamofire.request(retriveCustomerUrl, method: .get, parameters: json, encoding: URLEncoding.default, headers: nil).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                // print(myresponse.result.value)
                if let json = myresponse.result.value as? [[String: Any]] {

                    for alrvew in json{
                        let allData = CustomerDataModel.init(json: alrvew)
                        self.allCustomerLists.append(allData)
                    }
                    print(myresponse.result.value)
                }

            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
    }
    
    
    
    
}
