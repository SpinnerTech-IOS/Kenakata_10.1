//
//  AccountViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickLogout(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "USERISLOGIN")
        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainViewController)
    }
}
