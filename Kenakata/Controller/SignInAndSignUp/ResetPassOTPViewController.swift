//
//  ResetPassOTPViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 13/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage
import Realm
import RealmSwift

    
class ResetPassOTPViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var informationLbl: UILabel!
    
    @IBOutlet weak var otp11TxtField: UITextField!
        @IBOutlet weak var otp12TxtField: UITextField!
        @IBOutlet weak var otp13TxtField: UITextField!
        @IBOutlet weak var otp14TxtField: UITextField!
        @IBOutlet weak var otp15TxtField: UITextField!
        @IBOutlet weak var otp16TxtField: UITextField!
    
    var apiUsername = SingleTonManager.OTP_user
    var apiPass = SingleTonManager.OTP_pass
    var otpCode: String?
    var mobileNumber = ""
     var customerId = 0
    
    let otpSendUrl = SingleTonManager.OTP_URL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(mobileNumber)
        print(String(otpCode!))
         print(customerId)
    
        self.otp11TxtField.delegate = self
        self.otp12TxtField.delegate = self
        self.otp13TxtField.delegate = self
        self.otp14TxtField.delegate = self
        self.otp15TxtField.delegate = self
        self.otp16TxtField.delegate = self
        // Do any additional setup after loading the view.
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
                return true
            } else {
                return false
            }
        }
        let sms = "Welcome to AfiqSouq.com. Your OTP is : \(self.otpCode!)"
        
        let params = ["username": apiUsername, "password": apiPass, "number": mobileNumber, "message": sms ]
        Alamofire.request(otpSendUrl, method: .get, parameters: params as Parameters).validate(statusCode: 200..<299).responseJSON(completionHandler: {response in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    let data = JSON(value)
                    print("Data\(data)")

                }

            case .failure( let error):
                print(error)
                print(".....")
            }

        })
        print("OTP : \(self.otpCode!)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        otp11TxtField.becomeFirstResponder()
        otp11TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
        otp12TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
        otp13TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
        otp14TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
        otp15TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
        otp16TxtField.addTarget(self, action: #selector(textdidCgange(textfield:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textdidCgange(textfield: UITextField){
        let text = textfield.text
        if text?.utf16.count == 1{
            switch textfield {
            case otp11TxtField:
                otp12TxtField.becomeFirstResponder()
                break
                
            case otp12TxtField:
                otp13TxtField.becomeFirstResponder()
                break
                
            case otp13TxtField:
                otp14TxtField.becomeFirstResponder()
                break
                
            case otp14TxtField:
                otp15TxtField.becomeFirstResponder()
                break
                
            case otp15TxtField:
                otp16TxtField.becomeFirstResponder()
                break
                
            case otp16TxtField:
                otp16TxtField.resignFirstResponder()
                break
                
            default:
                break
            }
        }else{
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickResetPass(_ sender: Any) {
     
        if "Welcome to AfiqSouq.com. Your OTP is : \(self.otpCode!)" == "Welcome to AfiqSouq.com. Your OTP is : \(self.otp11TxtField.text!)\(self.otp12TxtField.text!)\(self.otp13TxtField.text!)\(self.otp14TxtField.text!)\(self.otp15TxtField.text!)\(self.otp16TxtField.text!)"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let resetVC = storyboard.instantiateViewController(withIdentifier: "UpdatePassViewController") as? UpdatePassViewController
            resetVC?.customerID = self.customerId
            self.present(resetVC!, animated: false)
            
        }else{
            
            let alertController = UIAlertController(title: "Wrong OTP COde!", message: "There was an error when attempting to Update pass", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
                self.present(signUpVC, animated: false)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }
}
