//
//  AddAReviewViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage

class AddAReviewViewController: UIViewController, UITextFieldDelegate {
    
    enum AddREviewError: Error {
        case addReviewFailed
        
    }
    @IBOutlet weak var reviewTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var review1Btn: UIButton!
    @IBOutlet weak var review2Btn: UIButton!
    @IBOutlet weak var review3Btn: UIButton!
    @IBOutlet weak var review4Btn: UIButton!
    @IBOutlet weak var review5Btn: UIButton!
    
    var productID : Int?
    
    let userURL = "https://afiqsouq.com/api/user/get_currentuserinfo/"
    let reviewURL = "https://afiqsouq.com/wp-json/wc/v3/products/reviews?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var rating = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOntap()
        reviewTxtField.delegate = self
        emailTextField.delegate = self
        nameTxtField.delegate = self
        
        print("id....\(self.productID)")
        getUser()
        navigationController!.navigationBar.topItem?.title = "Add Review"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        // Do any additional setup after loading the view.
    }
    
    func setImageOnAddReview(_rating: Int){
        if _rating == 1{
            review1Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review2Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
            review3Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
            review4Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
            review5Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
        }else if _rating == 2{
            review1Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review2Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review3Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
            review4Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
            review5Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
        }else if _rating == 3{
            review1Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review2Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review3Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review4Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
            review5Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
        }else if _rating == 4{
            review1Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review2Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review3Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review4Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review5Btn.setBackgroundImage(UIImage(named: "Group 1174"), for: .normal)
        }else if _rating == 5{
            review1Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review2Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review3Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review4Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
            review5Btn.setBackgroundImage(UIImage(named: "Group 643"), for: .normal)
        }
    }
    
    @IBAction func onClick1Review(_ sender: Any) {
        rating = 1
        setImageOnAddReview(_rating: rating)
    }
    @IBAction func onClick2Review(_ sender: Any) {
        rating = 2
        setImageOnAddReview(_rating: rating)
    }
    @IBAction func onClick3Review(_ sender: Any) {
        rating = 3
        setImageOnAddReview(_rating: rating)
    }
    @IBAction func onClick4Review(_ sender: Any) {
        rating = 4
        setImageOnAddReview(_rating: rating)
    }
    @IBAction func onClick5Review(_ sender: Any) {
        rating = 5
        setImageOnAddReview(_rating: rating)
    }
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        
        //        print("\(self.productID!)\(self.reviewTxtField!.text!)\(self.nameTxtField!.text!)\(self.emailTextField!.text!)\(self.rating)")
        if emailTextField.text != "" && nameTxtField.text != "" && reviewTxtField.text != ""{
            let dict: Dictionary<String, Any> = ["product_id": String(self.productID!), "review": self.reviewTxtField!.text!, "reviewer": self.nameTxtField!.text!, "reviewer_email": self.emailTextField!.text!, "rating": String(self.rating)]
            let url = URL(string: reviewURL)!
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options:[])
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                Alamofire.request(request).validate(statusCode: 200..<299).responseJSON(completionHandler: {
                    (response) in
                    switch response.result {
                    case .success(let data):
                        print(data)
                        let alertController = UIAlertController(title: "Successful!", message: "Review is added successfully", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let addReviewVC = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
                            addReviewVC.productId = self.productID
                            self.present(addReviewVC, animated: false)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    case .failure(let error):
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let cartVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                        self.navigationController?.pushViewController(cartVC, animated: false)
                        print(error)
                        
                    }
                })
            } catch {
                print("Failed to serialise and send JSON")
            }
            //            do {
            //                try newRequest(json: dict)
            //
            //                let alertController = UIAlertController(title: "Unable To Add Review!", message: "There was an error when attempting to Add Review", preferredStyle: .alert)
            //                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            //                    UIAlertAction in
            //
            //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //                    let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUp")
            //                    self.present(signUpVC, animated: false)
            //                }
            //                alertController.addAction(okAction)
            //                self.present(alertController, animated: true, completion: nil)
            //
            //            } catch {
            //                Alert.showBasic(title: "Unable To Login", message: "There was an error when attempting to login", vc: self)
            //
            //            }
            //            print(dict)
            //            let userData = try? JSONSerialization.data(withJSONObject: dict)
            //
            //
            //
            //            Alamofire.upload(multipartFormData: { (multiFoormData) in
            //                multiFoormData.append(userData!, withName: "review")
            //
            //            }, to: reviewURL, method: .post, headers: nil) { encodingResult in
            //                switch encodingResult {
            //                case .success(let upload, _, _):
            //                    upload.response { answer in
            //                        print(answer)
            //                        print("statusCode: \(answer.response?.statusCode)")
            //
            //                    }
            //                    upload.uploadProgress { progress in
            //                        //call progress callback here if you need it
            //                    }
            //                case .failure(let encodingError):
            //                    print("multipart upload encodingError: \(encodingError)")
            //                }
            //            }
            //
            //        }
            
        }
    }
    
    func newRequest(json: [String:Any]) throws {
        
        
    }
    
    func getUser(){
        let token = UserDefaults.standard.string(forKey: "access_token")
        let params = ["cookie": token!]
        Alamofire.request(userURL, method: .post, parameters: params as Parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    let data = JSON(value)
                    self.nameTxtField.text = "\(data["user"]["displayname"])"
                    self.emailTextField.text = "\(data["user"]["email"])"
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
        
    }
    
}
