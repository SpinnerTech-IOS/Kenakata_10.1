//
//  AddAReviewViewController.swift
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

class AddAReviewViewController: UIViewController {
    @IBOutlet weak var reviewTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var review1Btn: UIButton!
    @IBOutlet weak var review2Btn: UIButton!
    @IBOutlet weak var review3Btn: UIButton!
    @IBOutlet weak var review4Btn: UIButton!
    @IBOutlet weak var review5Btn: UIButton!
    
    var productID : Int?
    
     let userURL = "https://afiqsouq.com/api/user/get_currentuserinfo/"
    let reviewURL = "https://afiqsouq.com/wp-json/wc/v3/products/reviews?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var rating = 1
    override func viewDidLoad() {
      
        print("id....\(self.productID)")
        getUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClick1Review(_ sender: Any) {
        review1Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
        rating = 1
       }
       @IBAction func onClick2Review(_ sender: Any) {
        review2Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
        rating = 2
          }
       @IBAction func onClick3Review(_ sender: Any) {
        review3Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
        rating = 2
          }
       @IBAction func onClick4Review(_ sender: Any) {
        review4Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
        rating = 4
          }
       @IBAction func onClick5Review(_ sender: Any) {
        review5Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
        rating = 5
          }
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        
//        print("\(self.productID!)\(self.reviewTxtField!.text!)\(self.nameTxtField!.text!)\(self.emailTextField!.text!)\(self.rating)")
        if emailTextField.text != "" && nameTxtField.text != "" && reviewTxtField.text != ""{
            let dict: Dictionary<String, Any> = ["product_id": Int(self.productID!), "review": self.reviewTxtField!.text!, "reviewer": self.nameTxtField!.text!, "reviewer_email": self.emailTextField!.text!, "rating": self.rating]
            print(dict)
            let userData = try? JSONSerialization.data(withJSONObject: dict)
            Alamofire.upload(multipartFormData: { (multiFoormData) in
                multiFoormData.append(userData!, withName: "review")

            }, to: reviewURL, method: .post, headers: nil) { encodingResult in
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

    }
    
    func getUser(){
        let token = UserDefaults.standard.string(forKey: "access_token")
        let params = ["cookie": token!]
        Alamofire.request(userURL, method: .post, parameters: params as Parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    let data = JSON(value)
                    self.nameTxtField.text = "\(data["user"]["displayname"])"
                    self.emailTextField.text = "\(data["user"]["email"])"
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
        
    }
    
}
