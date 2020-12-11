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

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
        case invalidMobilenb
    }
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var textBox2: UITextField!
    @IBOutlet weak var dropDown2: UIPickerView!
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var nameTxtLbl: UITextField!
    @IBOutlet weak var emailTxtLbl: UITextField!
    @IBOutlet weak var passwordTxtLbl: UITextField!
    @IBOutlet weak var mobileNbTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    var nonce : String?
    var billing : [String:Any] = [:]
    var shipping : [String:Any] = [:]
    let signUpUrl = "https://afiqsouq.com/api/user/register/?"
    let nonceUrl = "https://afiqsouq.com/api/user/register/?json=get_nonce&controller=user&method=register"
    
    var list = ["Barguna", "Barisal", "Bhola", "Jhalokati", "Patuakhali", "Pirojpur", "Bandarban", "Brahmanbaria", "Chandpur", "Chittagong", "Comilla", "Cox's Bazar", "Feni", "Khagrachhari", "Lakshmipur", "Noakhali", "Rangamati", "Bandarban", "Brahmanbaria", "Chandpur", "Chittagong", "Comilla", "Cox's Bazar", "Feni", "Khagrachhari", "Lakshmipur", "Noakhali", "Rangamati", "Bagerhat", "Chuadanga", "Jessore", "Jhenaidah",  "Khulna", "Kushtia", "Magura", "Meherpur", "Narail", "Satkhira", "Jamalpur", "Mymensingh", "Netrakona", "Sherpur", "Bogra",    "Chapainawabganj","Joypurhat","Naogaon", "Natore", "Pabna", "Rajshahi", "Sirajganj", "Dinajpur", "Gaibandha", "Kurigram", "Lalmonirhat","Nilphamari", "Panchagarh", "Rangpur", "Thakurgaon", "Habiganj", "Moulvibazar", "Sunamganj","Sylhet",  "Barisal", "Chittagong", "Dhaka",  "Khulna",  "Mymensingh",  "Rajshahi",  "Rangpur", "Sylhet"]
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        if pickerView == dropDown2{
            return 1
        }
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return list[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.textBox2.text = self.list[row]
        self.dropDown2.isHidden = true
        
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.textBox2 {
            self.dropDown2.isHidden = false
            //if you don't want the users to se the keyboard type:
            
            textField.endEditing(true)
        }
        if textField == self.textBox {
            textField.text = "Bangladesh"
            textField.endEditing(false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOntap()
        nameTxtLbl.becomeFirstResponder()
        self.firstNameTxtField.delegate = self
        self.lastNameTxtField.delegate = self
        self.nameTxtLbl.delegate = self
        self.emailTxtLbl.delegate = self
        self.passwordTxtLbl.delegate = self
        self.mobileNbTxtField.delegate = self
        self.addressTxtField.delegate = self
        //        nameTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "user"), placeholder: "Your Name")
        //        emailTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "envelope"), placeholder: "Your Email")
        //        passwordTxtLbl.addLeftImageView(icon: #imageLiteral(resourceName: "lock"), placeholder: "Password")
        passwordTxtLbl.addRightImageView(image: #imageLiteral(resourceName: "eye-view"), isSecure: true)
        // Do any additional setup after loading the view.
        Alamofire.request(nonceUrl).validate(statusCode: 200..<299).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: Any]{
                    let data = JSON(value)
                    self.nonce = "\(data["nonce"])"
                    
                    print("Data\(data)")
                    
                }
                
            case .failure(let error):
                print(error)
                print("Wrong")
            }
            
        })
        
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signUpVC, animated: false)
        
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        
        do {
            try login()
            // Transition to next screen
            func random(digits:Int) -> String {
                var number = String()
                for _ in 1...digits {
                    number += "\(Int.random(in: 1...9))"
                }
                return number
            }
            let customKeys = ["first_name", "last_name", "company", "address_1", "address_2", "city", "state", "postcode", "country", "email", "phone",]
            let customValues = [firstNameTxtField.text!, lastNameTxtField.text!, " ", addressTxtField.text!, addressTxtField.text!, stateTextField.text!, " ", " ", countryTxtField.text!, emailTxtLbl.text!, mobileNbTxtField.text!,]
            let neDictionary = Dictionary(uniqueKeysWithValues: zip(customKeys,customValues))
            self.billing = neDictionary as [String: Any]
            let customKeys1 = ["first_name", "last_name", "company", "address_1", "address_2", "city", "state", "postcode", "country",]
            let customValues1 = [firstNameTxtField.text!, lastNameTxtField.text!, " ", addressTxtField.text!, addressTxtField.text!, stateTextField.text!, stateTextField.text!, " ", countryTxtField.text!,]
            let neDictionary1 = Dictionary(uniqueKeysWithValues: zip(customKeys1,customValues1))
            self.shipping = neDictionary1 as [String: Any]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let otpVC = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            otpVC.otpCode = random(digits: 6)
            otpVC.billing = self.billing
            otpVC.shipping = self.shipping
            otpVC.email = self.emailTxtLbl.text!
            otpVC.firstName = self.firstNameTxtField.text!
            otpVC.lastName = self.lastNameTxtField.text!
            otpVC.uniqUserName = self.nameTxtLbl.text!
            otpVC.mobileNumber = self.mobileNbTxtField.text!
            otpVC.userEmail = self.emailTxtLbl.text!
            otpVC.userPass = self.passwordTxtLbl.text!
            
            self.present(otpVC, animated: false)
        } catch LoginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        } catch LoginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "Please make sure you format your email correctly", vc: self)
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 4 characters", vc: self)
        } catch LoginError.invalidMobilenb {
            Alert.showBasic(title: "Invalid Mobile Number", message: "Please make sure you format your Mobile Number correctly", vc: self)
        } catch {
            Alert.showBasic(title: "Unable To Login", message: "There was an error when attempting to login", vc: self)
        }
    }
    func login() throws {
        
        let fName = firstNameTxtField.text!
        let lName = lastNameTxtField.text!
        let uName =  nameTxtLbl.text!
        let email =  emailTxtLbl.text!
        let password = passwordTxtLbl.text!
        let mobile =  mobileNbTxtField.text!
        let address = addressTxtField.text!
        let country =  countryTxtField.text!
        let state =  stateTextField.text!
        
        if !mobile.isValidPhoneNumber {
            throw LoginError.invalidMobilenb
        }
        
        
        if email.isEmpty || password.isEmpty || fName.isEmpty || lName.isEmpty || uName.isEmpty || mobile.isEmpty || address.isEmpty || country.isEmpty || state.isEmpty {
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

