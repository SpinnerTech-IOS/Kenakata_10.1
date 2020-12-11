//
//  SignInViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SignInViewController: UIViewController, UITextFieldDelegate {
    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
    }
    let loginURL = "https://afiqsouq.com/api/user/generate_auth_cookie?"
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var passwordTxtLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOntap()
        emailTxtLbl.delegate = self
        passwordTxtLbl.delegate = self
        //        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: ""), placeholder: "example@gmail.com")
        //        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: ""), placeholder: "1234")
        passwordTxtLbl.addRightImageView(image: #imageLiteral(resourceName: "eye-view"), isSecure: true)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "ForgotPassViewController")
        self.present(signUpVC, animated: false)
    }
    @IBAction func onClickSignUp(_ sender: Any) {
        print("signup")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUp")
        self.present(signUpVC, animated: false)
    }
    @IBAction func onClickLogin(_ sender: UIButton) {
        
        do {
            try login()
           //  Transition to next screen
                        SVProgressHUD.show(withStatus: "Loading...")
            
                        let params = ["email": emailTxtLbl!.text!, "password": passwordTxtLbl!.text!]
                        Alamofire.request(loginURL, method: .post, parameters: params as Parameters).validate(statusCode: 200..<299).responseJSON(completionHandler: { response in
                            switch response.result {
                            case .success(let data):
                                 print(data)
                                if let value = response.result.value{
                                    let data = JSON(value)
                                    print("Data\(data)")
                                    let token = data["cookie"]
                                    let user = data["user"]["email"]
                                    UserDefaults.standard.setLoggedIn(tokenText: token)
                                    if [self.emailTxtLbl.text!] == [user]{
                                        self.changeRootView()
                                    }
                                }
                                self.emailTxtLbl.text = nil
                                self.passwordTxtLbl.text = nil
                            case .failure(let error):
                                print(error)
                                print("Wrong")
                            }
                            SVProgressHUD.dismiss()
                        })
            
        } catch LoginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        } catch LoginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "Please make sure you format your email correctly", vc: self)
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 6 characters", vc: self)
        } catch {
            Alert.showBasic(title: "Unable To Login", message: "There was an error when attempting to login", vc: self)
        }
        
    }
    func changeRootView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainTabBar")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    func login() throws {
        
        let email = emailTxtLbl.text!
        let password = passwordTxtLbl.text!
        
        if email.isEmpty || password.isEmpty {
            throw LoginError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        if password.count < 4 {
            throw LoginError.incorrectPasswordLength
        }
        
        // Pretend this is great code that logs in my user.
        // It really is amazing...
    }
}
