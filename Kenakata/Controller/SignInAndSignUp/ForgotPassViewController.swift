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

class ForgotPassViewController: UIViewController, UITextFieldDelegate {
    
    enum ForgotPassError: Error {
        case incompleteForm
        case invalidEmail
        
    }
    @IBOutlet weak var emailTextField: UITextField!
    let retriveCustomerUrl = SingleTonManager.BASE_URL + "/wp-json/wc/v3/customers?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    var allCustomerLists: [CustomerDataModel] = []
    var allCustomer = [[String: Any]]()
    var isMatchedEmail = false
    var userEmail = ""
    var phoneNb = ""
    var cID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOntap()
        emailTextField.delegate = self
             
        print(",,,,,,,,,,,,,,,,,,,,,,,,,")
        // Do any additional setup after loading the view.
        
    }
    
    
    
    @IBAction func resetPasswordBtn(_ sender: Any) {
        
        do {
            try login()
            
                getAllCustomer()
            

            
            
        } catch ForgotPassError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        } catch ForgotPassError.invalidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "Please make sure you format your email correctly", vc: self)
        }catch {
            Alert.showBasic(title: "Unable To Reset Password", message: "There was an error when attempting to login", vc: self)
        }
        
        
    }
    func getAllCustomer(){
        let json = [ "email" : emailTextField.text!]
        
        
        Alamofire.request(retriveCustomerUrl, method: .get, parameters: json, encoding: URLEncoding.default, headers: nil).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                // print(myresponse.result.value)
                if let json = myresponse.result.value as? [[String: Any]] {
                    
                    for alrvew in json{
                        let allData = CustomerDataModel.init(json: alrvew)
                        self.allCustomerLists.append(allData)
                    }
                    for i in 0..<self.allCustomerLists.count{
                        
                        self.userEmail = self.allCustomerLists[i].email
                        self.phoneNb = self.allCustomerLists[i].billing.phone
                        self.cID = self.allCustomerLists[i].id
                        
                    }
                    if !self.userEmail.isEmpty{
                        if self.emailTextField.text == self.userEmail{
                            func random(digits:Int) -> String {
                                var number = String()
                                for _ in 1...digits {
                                    number += "\(Int.random(in: 1...9))"
                                }
                                return number
                            }
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let otpVC = storyboard.instantiateViewController(withIdentifier: "ResetPassOTPViewController") as? ResetPassOTPViewController
                            otpVC!.otpCode = random(digits: 6)
                            otpVC!.mobileNumber = self.phoneNb
                            otpVC!.customerId = self.cID
                            otpVC!.otpCode = random(digits: 6)
                            self.present(otpVC!, animated: false)
                        }else{
                            let alertController = UIAlertController(title: "Wrong Email!", message: "Please Try Again", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
                                self.present(signUpVC, animated: false)
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }else{
                        let alertController = UIAlertController(title: "Wrong Email!", message: "Please Try Again", preferredStyle: .alert)
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
                
            case let .failure(error):
                let alertController = UIAlertController(title: "Wrong Email!", message: "Please Try Again", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
                    self.present(signUpVC, animated: false)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                print(error)
                print("Wrong")
            }
        }
    }
    
    
    func login() throws {
        
        let emailTxt = emailTextField.text!
        
        if emailTxt.isEmpty {
            throw ForgotPassError.incompleteForm
        }
        
        if !emailTxt.isValidEmail {
            throw ForgotPassError.invalidEmail
        }
        
    }
    
}
