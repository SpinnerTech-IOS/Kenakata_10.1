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
    
     let userURL = "https://afiqsouq.com/api/user/get_currentuserinfo/"
    var rating = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClick1Review(_ sender: Any) {
       
       }
       @IBAction func onClick2Review(_ sender: Any) {
          }
       @IBAction func onClick3Review(_ sender: Any) {
          }
       @IBAction func onClick4Review(_ sender: Any) {
          }
       @IBAction func onClick5Review(_ sender: Any) {
          }
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        

    }
    
    func addReview(){
        let token = UserDefaults.standard.string(forKey: "access_token")
        let params = ["product_id": token!, "review": token!, "reviewer": token!, "reviewer_email": token!, "rating": token!]
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
