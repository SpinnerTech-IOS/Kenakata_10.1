//
//  UpdatePassViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 14/12/20.
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

class UpdatePassViewController: UIViewController {
    var customerID  = 0
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addRightImageView(image: #imageLiteral(resourceName: "eye-view"), isSecure: true)
        print(self.customerID)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickUpdatePassword(_ sender: Any) {
        if passwordTextField.text!.isEmpty{
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        }else{
            let url = URL(string: SingleTonManager.BASE_URL + "wp-json/wc/v3/customers/" + String(customerID) + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key)
            do {
                let json = ["password" : passwordTextField.text]
                let jsonData = try JSONSerialization.data(withJSONObject: json, options:[])
                var request = URLRequest(url: url!)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                Alamofire.request(request).validate(statusCode: 200..<299).responseJSON(completionHandler: {
                    (response) in
                    switch response.result {
                    case .success( _):
                        let alertController = UIAlertController(title: "Password Updated!", message: "Your Password is updated successfully", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
                            self.present(signUpVC, animated: false)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    case .failure(_):
                        let alertController = UIAlertController(title: "Unable To Update password!", message: "There was an error when attempting to Update pass", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
                            self.present(signUpVC, animated: false)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            } catch {
                print("Failed to serialise and send JSON")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
                self.present(signUpVC, animated: false)
            }
        }
    }
}
