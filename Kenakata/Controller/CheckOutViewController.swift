//
//  CheckOutViewController.swift
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
class CheckOutViewController: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    let orderUrl = "https://afiqsouq.com//wp-json/wc/v3/orders?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"

    let userURL = "https://afiqsouq.com/api/user/get_currentuserinfo/"
    var firstName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getUser()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        // Do any additional setup after loading the view.
        print(firstName)
        
    }
    var paymentMethod  =  "cod"
    var paymentMethodTitle = "Cash on delivery"
    var setPaid = true
    var billing = [
        "first_name" : "John",
        "last_name": "Doe",
        "address_1": "969 Market",
        "address_2": "",
        "city": "Dhaka",
        "state": "",
        "postcode": "1205",
        "country": "BD",
        "email": "john.doe@example.com",
        "phone": ""
    ]
    var shipping = [
        "first_name" : "John",
        "last_name": "Doe",
        "address_1": "969 Market",
        "address_2": "",
        "city": "Dhaka",
        "state": "",
        "postcode": "1205",
        "country": "BD",
    ]
    var line_items = [
        [
            "product_id": 93,
            "quantity": 2
        ],
        [
            "product_id": 22,
            "variation_id": 23,
            "quantity": 1
        ]
    ]
    var shipping_lines = [
        [
            "method_id": "flat_rate",
            "method_title": "Flat Rate",
            "total": "10.00"
        ]
    ]
    
    
    
    @IBAction func onClickPlaceOrder(_ sender: Any) {
        let dict: Dictionary<String, Any> = ["payment_method": self.paymentMethod, "payment_method_title": self.paymentMethodTitle, "set_paid": self.setPaid, "billing": self.billing, "shipping": self.shipping, "line_items": self.line_items, "shipping_lines": self.shipping_lines, ]
        let userData = try? JSONSerialization.data(withJSONObject: dict)
        Alamofire.upload(multipartFormData: { (multiFoormData) in
            multiFoormData.append(userData!, withName: "data")
            
        }, to: orderUrl, method: .post, headers: nil) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.response { answer in
                    print(answer)
                    print("statusCode: \(answer.response?.statusCode)")
                }
                upload.uploadProgress { progress in
                    //call progress callback here if you need it
                }
            case .failure(let encodingError):
                print("multipart upload encodingError: \(encodingError)")
            }
        }
    }
    
    @IBAction func onClickMasterCard(_ sender: Any) {
    }
    @IBAction func onClickCashOnPaypel(_ sender: Any) {
    }
    @IBAction func onClickCashOnDelivery(_ sender: Any) {
    }
    
    @IBAction func onClickBankTransfer(_ sender: Any) {
    }
    func getUser(){
        let token = UserDefaults.standard.string(forKey: "access_token")
        let params = ["cookie": token!]
        Alamofire.request(userURL, method: .post, parameters: params as Parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    let data = JSON(value)
                    self.firstName = data["user"]["displayname"].stringValue
                    self.nameLbl.text = "\(data["user"]["displayname"])"
                    self.addressLbl.text = "\(data["user"]["description"])"
                    print(data["user"])
                }
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
        
    }
    
}

