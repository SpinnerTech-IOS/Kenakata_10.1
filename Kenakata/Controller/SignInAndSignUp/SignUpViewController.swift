//
//  SignUpViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var textBox2: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var dropDown2: UIPickerView!

    var list = ["Bangladesh", "Philippines"]
    var list2 = ["Dhaka", "Chittagong", "Jamalpur", "Kustia", "Natore"]
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        if pickerView == dropDown2{
            return 1
        }
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == dropDown2{
            return list2.count
        }
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dropDown2{
            self.view.endEditing(true)
            return list2[row]
        }
        self.view.endEditing(true)
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dropDown2{
            self.textBox2.text = self.list2[row]
            self.dropDown2.isHidden = true
        }
        if pickerView == dropDown{
            self.textBox.text = self.list[row]
            self.dropDown.isHidden = true
        }

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textBox {
            self.dropDown.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
        if textField == self.textBox2 {
            self.dropDown.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var nameTxtLbl: UITextField!
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var passwordTxtLbl: UITextField!
    @IBOutlet weak var mobileNbTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    var nonce : String?
    let signUpUrl = "https://afiqsouq.com/api/user/register/?"
    let nonceUrl = "https://afiqsouq.com/api/user/register/?json=get_nonce&controller=user&method=register"
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxtLbl.becomeFirstResponder()
        
//        nameTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "user"), placeholder: "Your Name")
//        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "envelope"), placeholder: "Your Email")
//        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "lock"), placeholder: "Password")
        passwordTxtLbl.addRightImageView(image: #imageLiteral(resourceName: "eye-view"), isSecure: true)
        // Do any additional setup after loading the view.
        Alamofire.request(nonceUrl).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: Any]{
                    let data = JSON(value)
                    self.nonce = "\(data["nonce"])"
                    
                    print("Data\(data)")
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signUpVC, animated: false)
        
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        if (nameTxtLbl.text != "" && emailTxtLbl.text != "" && passwordTxtLbl.text != "" && mobileNbTxtField.text != "" && addressTxtField.text != ""){
            
            
            SVProgressHUD.show(withStatus: "Loading...")
            //            let headers: HTTPHeaders =
            let params = ["email": emailTxtLbl!.text!, "username": nameTxtLbl.text!, "user_pass": passwordTxtLbl!.text!, "description": addressTxtField!.text!, "nonce" : self.nonce! ]
            Alamofire.request(signUpUrl, method: .post, parameters: params as Parameters).responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value{
                        let data = JSON(value)
                        
                        func random(digits:Int) -> String {
                            var number = String()
                            for _ in 1...digits {
                                number += "\(Int.random(in: 1...9))"
                            }
                            return number
                        }
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let otpVC = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                        otpVC.otpCode = random(digits: 6)
                        otpVC.mobileNumber = self.mobileNbTxtField.text!
                        otpVC.userEmail = self.emailTxtLbl.text!
                        otpVC.userPass = self.passwordTxtLbl.text!
                        
                        self.present(otpVC, animated: false)
                        
                        
                    }
                    
                    self.emailTxtLbl.text = nil
                    self.passwordTxtLbl.text = nil
                    self.nameTxtLbl.text = nil
                    self.mobileNbTxtField.text = nil
                    self.addressTxtField.text = nil
                case let .failure(error):
                    print(error)
                    print("Wrong")
                }
                SVProgressHUD.dismiss()
            }
            
        }
        
    }
    
    
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
