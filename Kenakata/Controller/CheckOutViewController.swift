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
//import SSLCommerzSDK

//class CheckOutViewController: UIViewController,SSLCommerzDelegate {
class CheckOutViewController: UIViewController {
    
    
    @IBOutlet weak var mobileNbLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    var line_items : [[String:Any]] = []
   
    
    var allCustomerLists: [CustomerDataModel] = []
    var allCustomer = [[String: Any]]()
    let retriveCustomerUrl = SingleTonManager.BASE_URL + "wp-json/wc/v3/customers?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    let orderUrl = SingleTonManager.BASE_URL + "wp-json/wc/v3/orders?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    
    let userURL = SingleTonManager.BASE_URL + "api/user/get_currentuserinfo/"
    var amountToPay: Double?
    var cID = 0
    var totalTax = 0.00
    var subtotal = 0.00
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
    var sslComerzData : [String:Any] = [:]
    let realm = try! Realm()
    let results = try! Realm().objects(CartDataModel.self).sorted(byKeyPath: "id")
    
    // var sslCom : SSLCommerz?
    var transactionID = ""
    var paymentMethod  =  "cod"
    var paymentMethodTitle = "Cash on delivery"
    var setPaid = false
    var shipping_lines = [
        [
            "method_id": "flat_rate",
            "method_title": "Flat Rate",
            "total": "105"
        ]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<results.count{
            let customKeys = ["product_id", "quantity"]
            let customValues = [Int(results[i].productId)!, results[i].ProductQuantity] as [Any]
            let neDictionary = Dictionary(uniqueKeysWithValues: zip(customKeys,customValues))
            self.line_items.append(neDictionary)
        }
        /// self.navigationController?.setNavigationBarHidden(true, animated: false)
        getUser()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        // Do any additional setup after loading the view.
        getUserInfo()
        print(self.allCustomerLists)
    }
    func getUserInfo() {
        for i in 0..<self.allCustomerLists.count{
            print(self.allCustomerLists[i])
            print(self.allCustomerLists[i].shipping)
            print(self.allCustomerLists[i].billing)}
        let customKeys = ["first_name", "last_name", "address_1", "address_2", "city", "state", "postcode", "country", "email", "phone"]
        let customValues = [firstName, lastName, address, address, city, city, postcode, country, email, phone]
        let neDictionary = Dictionary(uniqueKeysWithValues: zip(customKeys,customValues))
        self.billing = neDictionary as [String: Any]
        
        let customKeysShipping = ["first_name", "last_name", "address_1", "address_2", "city", "state", "postcode", "country"]
        let customValuesShipping = [firstName, lastName, address, address, city, city, postcode, country]
        let neDictionaryShipping = Dictionary(uniqueKeysWithValues: zip(customKeysShipping,customValuesShipping))
        self.shipping = neDictionaryShipping as [String: Any]
        
        let sslComerzData = ["withStoreID", "storePassword", "amountToPay", "amountCurrency", "withCustomerEmail", "customerName", "customerContactNumber", "customerAddress1", "shipmentCity"]
        //                let customValuesslComerzData = ["afiqsouqlive", "5FA907E4DA48684914", String(amountToPay!), "BDT", email, firstName, phone, address, address]
        let customValuesslComerzData = ["greed5fb4d1ed05847", "greed5fb4d1ed05847@ssl", String(amountToPay!), "BDT", email, firstName, phone, address, address]
        let neDictionarysslComerzData = Dictionary(uniqueKeysWithValues: zip(sslComerzData,customValuesslComerzData))
        self.sslComerzData = neDictionarysslComerzData as [String: Any]
    }
    
    @IBAction func onClickPlaceOrder(_ sender: Any) {
        placeOrder()
    }
    
    @IBAction func onClickMasterCard(_ sender: Any) {
        
        payWithSSL()
    }
    @IBAction func onClickCashOnPaypel(_ sender: Any) {
        
        payWithSSL()
    }
    @IBAction func onClickCashOnDelivery(_ sender: Any) {
        
        self.paymentMethod  =  "cod"
        self.paymentMethodTitle = "Cash on delivery"
        self.setPaid = false
    }
    
    @IBAction func onClickBankTransfer(_ sender: Any) {
        
        payWithSSL()
    }
    
    
    func payWithSSL() -> Void {
        //        self.transactionID = self.randomString(length: 9)
        //        if let stringAmount = self.sslComerzData["amountToPay"]{
        //            let amount = (stringAmount as! NSString).doubleValue
        //            let customerName = "\(String(describing: self.billing["first_name"]!)) \(String(describing: self.billing["last_name"]!))"
        //            let storeId = self.sslComerzData["withStoreID"] as! String
        //            let storePassword = self.sslComerzData["storePassword"] as! String
        //
        //            // MARK:- SSL Commerz Start
        //            sslCom = SSLCommerz.init(integrationInformation: .init(storeID: storeId, storePassword: storePassword, totalAmount: amount, currency: "BDT", transactionId: self.transactionID, productCategory: "goods"), emiInformation: nil, customerInformation: .init(customerName: customerName, customerEmail: self.billing["email"] as! String, customerAddressOne: self.billing["address_1"] as! String, customerCity: self.billing["city"] as! String, customerPostCode: self.billing["postcode"] as! String, customerCountry: "Bangladesh", customerPhone: self.billing["phone"] as! String), shipmentInformation: nil, productInformation: nil, additionalInformation: nil)
        //            sslCom?.delegate = self
        //            sslCom?.start(in: self, shouldRunInTestMode: true)
        //        }
        
    }
    //    func transactionCompleted(withTransactionData transactionData: TransactionDetails?) {
    //        if transactionData?.status == "VALID" || transactionData?.status == "VALIDATED"{
    //            paymentMethod = "Gateway"
    //            paymentMethodTitle = "Online Payment"
    //            setPaid = true
    //            placeOrder()
    //        }
    //    }
    func placeOrder() -> Void{
        //, "total_tax": String(self.totalTax), "total": String(self.amountToPay!), "shipping_total": "105",
        let dict: Dictionary<String, Any> = ["customer_id": self.cID, "payment_method": self.paymentMethod, "payment_method_title": self.paymentMethodTitle, "set_paid": self.setPaid, "billing": self.billing, "shipping": self.shipping, "line_items": self.line_items, "shipping_lines": self.shipping_lines, ]
                
        let userData = try? JSONSerialization.data(withJSONObject: dict)
        if let JSONString = String(data: userData!, encoding: String.Encoding.utf8) {
           print(JSONString)
        }
        Alamofire.upload(multipartFormData: { (multiFoormData) in
              for (key, value) in dict {
                 multiFoormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                       //multiFoormData.append(userData!, withName: "data")
                  }
        
              
              if let data = userData{
                  multiFoormData.append(data, withName: "data")
              }
           

        }, to: orderUrl, method: .post, headers: nil) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.response { answer in
                    //                    print(answer)
                    //  print("statusCode: \answer.response?.statusCode)")
                      print(answer.response)
                    // delete all data from cart
                    let realm = try! Realm()
                    let allUploadingObjects = realm.objects(CartDataModel.self)

                    try! realm.write {
                        realm.delete(allUploadingObjects)
                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let cartVC = storyboard.instantiateViewController(withIdentifier: "CompleteViewController")
                    self.present(cartVC, animated: false)


                }
                upload.uploadProgress { progress in
                    //call progress callback here if you need it
                }
            case .failure(let encodingError):
                print("multipart upload encodingError: \(encodingError)")
            }
        }
    }
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func getUserInformation(){
        let json = [ "email" :  self.email ]
        
        DispatchQueue.global(qos: .userInteractive).async {
            Alamofire.request(self.retriveCustomerUrl, method: .get, parameters: json, encoding: URLEncoding.default, headers: nil).responseJSON { (myresponse) in
                switch myresponse.result{
                case .success:
                    // print(myresponse.result.value)
                    if let json = myresponse.result.value as? [[String: Any]] {
                        DispatchQueue.main.async {
                            for alrvew in json{
                                let allData = CustomerDataModel.init(json: alrvew)
                                self.allCustomerLists.append(allData)
                            }
                            for i in 0..<self.allCustomerLists.count{
                                self.nameLbl.text = self.allCustomerLists[i].username
                                self.addressLbl.text = self.allCustomerLists[i].billing.address_1
                                self.mobileNbLbl.text = self.allCustomerLists[i].billing.phone
                                self.firstName = self.allCustomerLists[i].username
                                self.city = self.allCustomerLists[i].billing.state!
                                self.email = self.allCustomerLists[i].email
                                self.phone = self.allCustomerLists[i].billing.phone
                                self.address = self.allCustomerLists[i].billing.address_1!
                                self.cID = self.allCustomerLists[i].id
                                self.getUserInfo()
                            }
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                    print("Wrong")
                }
            }
        }
        
    }
    func getUser(){
        let token = UserDefaults.standard.string(forKey: "access_token")
        let params = ["cookie": token!]
        Alamofire.request(userURL, method: .post, parameters: params as Parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    
                    let data = JSON(value)
                    
                    self.email = data["user"]["email"].stringValue
                    self.getUserInformation()
                    self.getUserInfo()
                }
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
        
    }
    
}

