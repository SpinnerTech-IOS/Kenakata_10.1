//
//  SignInViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

  
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var passwordTxtLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "user"), placeholder: "example@gmail.com")
        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "lock"), placeholder: "1234")
        passwordTxtLbl.addRightImageView(image: #imageLiteral(resourceName: "eye-view"))
        // Do any additional setup after loading the view.
    }
    

}
