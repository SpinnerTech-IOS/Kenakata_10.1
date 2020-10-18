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

class SignInViewController: UIViewController {
    let loginURL = "https://afiqsouq.com/api/oauth/token/"
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
    
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        
        if emailTxtLbl.text != "" && passwordTxtLbl.text != "" {
            SVProgressHUD.show(withStatus: "Loading...")
            //            let headers: HTTPHeaders =
            let params = ["email": emailTxtLbl!.text!, "password": passwordTxtLbl!.text!]
            Alamofire.request(loginURL, method: .post, parameters: params as Parameters).responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value{
                        let data = JSON(value)
                        let token = data["success"]["token"]
                        print("successfull: \(token)")
                        UserDefaults.standard.setLoggedIn(tokenText: token)
                        self.changeRootView()
                    }
                    self.emailTxtLbl.text = nil
                    self.passwordTxtLbl.text = nil
                case let .failure(error):
                    print(error)
                    print("Wrong")
                }
                SVProgressHUD.dismiss()
            }
            
        }
    }
    func changeRootView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainTabBar")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}
