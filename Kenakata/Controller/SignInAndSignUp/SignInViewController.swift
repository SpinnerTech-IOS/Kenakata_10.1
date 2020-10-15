//
//  SignInViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    var isLogin = false
    var userName = "sifat@gmail.com"
    var password = "1234"
    var customerData = [CustomerData]()
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var passwordTxtLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "user"), placeholder: "example@gmail.com")
        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "lock"), placeholder: "1234")
        passwordTxtLbl.addRightImageView(image: #imageLiteral(resourceName: "eye-view"), isSecure: true)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        if (String(emailTxtLbl.text!) == userName && String(passwordTxtLbl.text!) == password){
            
            print("Login")
            UserDefaults.standard.set(true, forKey: "USERISLOGIN")
            UserDefaults.standard.synchronize()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController")
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
            }else{
            let alert = UIAlertController(title: "Error", message: "Wrong User Name or Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)        }
    }
    
}
