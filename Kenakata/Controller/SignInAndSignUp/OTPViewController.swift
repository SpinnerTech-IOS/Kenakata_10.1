//
//  OTPViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 6/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class OTPViewController: UIViewController {
    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var otp1TxtField: UITextField!
    @IBOutlet weak var otp2TxtField: UITextField!
    @IBOutlet weak var otp3TxtField: UITextField!
    @IBOutlet weak var otp4TxtField: UITextField!
    @IBOutlet weak var otp5TxtField: UITextField!
    @IBOutlet weak var otp6TxtField: UITextField!
    var mobileNumber : String?
    var otpCode: String?
    var userEmail: String?
    var userPass: String?
    var checkOtp: String?
    var apiUsername = "afiqsouq2021"
    var apiPass = "12afiqsouq3434$"
    
    let otpSendUrl = "http://66.45.237.70/api.php?"
    let loginURL = "https://afiqsouq.com/api/user/generate_auth_cookie?"
    override func viewDidLoad() {
        super.viewDidLoad()
        let sms = "OTP : \(self.otpCode!)"
    
        let params = ["username": apiUsername, "password": apiPass, "number": mobileNumber!, "message": sms ]
        Alamofire.request(otpSendUrl, method: .get, parameters: params as Parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    let data = JSON(value)
                    print("Data\(data)")
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        
        }
        
    }
    
    
    
    @IBAction func onClickVarifyBtn(_ sender: Any) {
        print("OTP : \(self.otpCode!)")
        print("OTP : \(self.otp1TxtField.text!)\(self.otp2TxtField.text!)\(self.otp3TxtField.text!)\(self.otp4TxtField.text!)\(self.otp5TxtField.text!)\(self.otp6TxtField.text!)")
        if "OTP : \(self.otpCode!)" == "OTP : \(self.otp1TxtField.text!)\(self.otp2TxtField.text!)\(self.otp3TxtField.text!)\(self.otp4TxtField.text!)\(self.otp5TxtField.text!)\(self.otp6TxtField.text!)"{
            SVProgressHUD.show(withStatus: "Loading...")
            //            let headers: HTTPHeaders =
            let params = ["email": userEmail!, "password": userPass!]
            Alamofire.request(loginURL, method: .post, parameters: params as Parameters).responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value{
                        let data = JSON(value)
                        print("Data\(data)")
                        let token = data["cookie"]
                        let user = data["user"]["email"]
                        UserDefaults.standard.setLoggedIn(tokenText: token)
                        if [self.userEmail!] == [user]{
                            self.changeRootView()
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                    print("Wrong")
                }
                
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        otp1TxtField.becomeFirstResponder()
        otp1TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
         otp2TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
         otp3TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
         otp4TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
         otp5TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
         otp6TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
       
    }
    
    func changeRootView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainTabBar")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    @objc func textdidCgange(textfield: UITextField){
        let text = textfield.text
        if text?.utf16.count == 1{
            switch textfield {
            case otp1TxtField:
                otp2TxtField.becomeFirstResponder()
                break
                
            case otp2TxtField:
                otp3TxtField.becomeFirstResponder()
                break
                
            case otp3TxtField:
                otp4TxtField.becomeFirstResponder()
                break
                
            case otp4TxtField:
                otp5TxtField.becomeFirstResponder()
                break
                
            case otp5TxtField:
                otp6TxtField.becomeFirstResponder()
                break
                
            case otp6TxtField:
                otp6TxtField.resignFirstResponder()
                break
                
            default:
                break
            }
        }else{
            
        }
        
    }
}
