//
//  SettingsViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Settings"
        // Do any additional setup after loading the view.
    }
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.logout()
        
    }

}
