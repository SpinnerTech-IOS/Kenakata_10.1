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

class SignUpViewController: UIViewController {
    
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
        
        nameTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "user"), placeholder: "Your Name")
        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "envelope"), placeholder: "Your Email")
        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "lock"), placeholder: "Password")
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
