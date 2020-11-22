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
     var line_items : [[String:Any]] = []
    let orderUrl = "https://afiqsouq.com//wp-json/wc/v3/orders?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"

    let userURL = "https://afiqsouq.com/api/user/get_currentuserinfo/"
    var firstName = ""
    var lastName = ""
    var city = ""
    var email = ""
    var address = ""
    var country = ""
    var postcode = ""
    var phone = ""
    var shippingLine : NSMutableDictionary = NSMutableDictionary()
    var billing : [String:Any] = [:]
    var shipping : [String:Any] = [:]
    let realm = try! Realm()
    let results = try! Realm().objects(CartDataModel.self).sorted(byKeyPath: "id")
    
    func getUserInfo() {
        
        let customKeys = ["first_name", "last_name", "address_1", "address_2", "city", "state", "postcode", "country", "email", "phone"]
        let customValues = [firstName, lastName, address, address, city, city, postcode, country, email, phone]
        let neDictionary = Dictionary(uniqueKeysWithValues: zip(customKeys,customValues))
        self.billing = neDictionary as [String: Any]
       
        let customKeysShipping = ["first_name", "last_name", "address_1", "address_2", "city", "state", "postcode", "country"]
        let customValuesShipping = [firstName, lastName, address, address, city, city, postcode, country]
        let neDictionaryShipping = Dictionary(uniqueKeysWithValues: zip(customKeysShipping,customValuesShipping))
        self.shipping = neDictionaryShipping as [String: Any]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<results.count{
        let customKeys = ["product_id", "quantity"]
            let customValues = [Int(results[i].productId)!, results[i].ProductQuantity] as [Any]
            let neDictionary = Dictionary(uniqueKeysWithValues: zip(customKeys,customValues))
            self.line_items.append(neDictionary)
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getUser()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        // Do any additional setup after loading the view.
     
            
    }
    var paymentMethod  =  "cod"
    var paymentMethodTitle = "Cash on delivery"
    var setPaid = true
    var shipping_lines = [
        [
            "method_id": "flat_rate",
            "method_title": "Flat Rate",
            "total": "10.00"
        ]
    ]
    
    
    
    @IBAction func onClickPlaceOrder(_ sender: Any) {
        let dict: Dictionary<String, Any> = ["payment_method": self.paymentMethod, "payment_method_title": self.paymentMethodTitle, "set_paid": self.setPaid, "billing": self.billing, "shipping": self.shipping, "line_items": self.line_items, "shipping_lines": self.shipping_lines, ]
        print(dict)
        let userData = try? JSONSerialization.data(withJSONObject: dict)
        Alamofire.upload(multipartFormData: { (multiFoormData) in
            multiFoormData.append(userData!, withName: "data")

        }, to: orderUrl, method: .post, headers: nil) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.response { answer in
                    print(answer)
                    print("statusCode: \(answer.response?.statusCode)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let cartVC = storyboard.instantiateViewController(withIdentifier: "CompleteViewController")
                    self.navigationController?.pushViewController(cartVC, animated: false)
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
                    self.city = data["user"]["description"].stringValue
                    self.email = data["user"]["email"].stringValue
                    self.address = data["user"]["description"].stringValue
                    self.nameLbl.text = "\(data["user"]["displayname"])"
                    self.addressLbl.text = "\(data["user"]["description"])"
                    self.getUserInfo()
                }
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
        
    }
    
}

