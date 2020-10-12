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
    let userName =
    "sifat@gmail.com"
    let password = 1234
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var passwordTxtLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "user"), placeholder: "example@gmail.com")
        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "lock"), placeholder: "1234")
        passwordTxtLbl.addRightImageView(image: #imageLiteral(resourceName: "eye-view"), isSecure: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        if (String(emailTxtLbl.text!) == userName && Int(passwordTxtLbl.text!) == password){
        
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
