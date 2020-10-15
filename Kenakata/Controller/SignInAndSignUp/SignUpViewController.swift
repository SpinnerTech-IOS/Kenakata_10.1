//
//  SignUpViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTxtLbl: UITextField!
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var passwordTxtLbl: UITextField!
    
    var customerData = [CustomerData]()
    var userName = String()
    var userEmail = String()
    var userPassword = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        customerData = [CustomerData(userName: userName, userEmail: userEmail, userPassword: userPassword)]
        nameTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "user"), placeholder: "Your Name")
        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "envelope"), placeholder: "Your Email")
        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "lock"), placeholder: "Password")
        passwordTxtLbl.addRightImageView(image: #imageLiteral(resourceName: "eye-view"), isSecure: true)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickSignUp(_ sender: Any) {
        if (nameTxtLbl.text == "" || emailTxtLbl.text == "" || passwordTxtLbl.text == ""){
            return
        }else{
            userName = nameTxtLbl.text!
            userEmail = emailTxtLbl.text!
            userPassword = passwordTxtLbl.text!
            print("DataLoaded")
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
