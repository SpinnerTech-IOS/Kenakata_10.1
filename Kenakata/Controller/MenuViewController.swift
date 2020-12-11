//
//  MenuViewController.swift
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

class MenuViewController: UIViewController {
    @IBOutlet weak var nameTxxtKbl: UILabel!
        @IBOutlet weak var emailTxxtKbl: UILabel!
    let userURL = "https://afiqsouq.com/api/user/get_currentuserinfo/"
    override func viewDidLoad() {
        super.viewDidLoad()
        //  let storyboard = UIStoryboard(name: "Main", bundle: nil)
        showAnimate()
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
                    self.nameTxxtKbl.text = "\(data["user"]["displayname"])"
                    self.emailTxxtKbl.text = "\(data["user"]["email"])"
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
            
        }
        
    }
    
    @IBAction func Close_popupView(_ sender: Any) {
        removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }
    
    
    @IBAction func onClickHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    @IBAction func onClickCatagories(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "Catagories")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    @IBAction func onClickNewArivals(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    
    @IBAction func onClickTopDeals(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
    
    @IBAction func onClickHelp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "LiveChatViewController")
        self.navigationController?.pushViewController(collectionVC, animated: false)
    }
}
