//
//  AccountViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import Realm
class AccountViewController: UIViewController {
    let userURL = "https://afiqsouq.com/api/user/get_currentuserinfo/"
    var activityIndicator = UIActivityIndicatorView(style: .gray)
    
    @IBOutlet weak var nameTxtLbl: UILabel!
    @IBOutlet weak var emailTxtLbl: UILabel!
    @IBOutlet weak var myProfileTxtLbl: UILabel!
    var userEmail = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        addMenuBtn()
        navigationController!.navigationBar.topItem?.title = "My Account"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        getUser()
        
        // Do any additional setup after loading the view.
    }
    func getUser(){
        let token = UserDefaults.standard.string(forKey: "access_token")
        let params = ["cookie": token!]
        Alamofire.request(userURL, method: .post, parameters: params as Parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    let data = JSON(value)
                    self.nameTxtLbl.text = "\(data["user"]["displayname"])"
                    self.emailTxtLbl.text = "\(data["user"]["email"])"
                    self.userEmail = "\(data["user"]["email"])"
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
        
    }
    
    @IBAction func onClickRewards(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "RewardsViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    @IBAction func onClickSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    
    @IBAction func onClickTransection(_ sender: Any) {
    }
    @IBAction func onClickMyWallet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "MyWalletViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    @IBAction func onClickProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.searchEmail = userEmail
        self.navigationController?.pushViewController(profileVC, animated: false)
    }
    @IBAction func onClickOrder(_ sender: Any) {
    }
    @IBAction func onClickGiftVoucher(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "GiftAndVoucherViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
        
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.logout()
        
    }
    func startIndicator()
    {
        //creating view to background while displaying indicator
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = .black
        
        //creating view to display lable and indicator
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 110, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor =  .black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        //Preparing activity indicator to load
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.frame = CGRect(x: 40, y: 12, width: 40, height: 60)
        self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingView.addSubview(activityIndicator)
        
        //creating label to display message
        let label = UILabel(frame: CGRect(x: 5, y: 55, width: 120, height: 20))
        label.text = "Loading..."
        label.textColor = UIColor.white
        label.bounds = CGRect(x: 0,y: 0,width: loadingView.frame.size.width / 2,height: loadingView.frame.size.height / 2)
        label.font = UIFont.systemFont(ofSize: 12)
        loadingView.addSubview(label)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        
        self.activityIndicator.startAnimating()
    }
    func stopIndicator()
    {
        UIApplication.shared.endIgnoringInteractionEvents()
        self.activityIndicator.stopAnimating()
        ((self.activityIndicator.superview as UIView?)?.superview as UIView?)!.removeFromSuperview()
    }
}
