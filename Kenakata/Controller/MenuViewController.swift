//
//  MenuViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Do any additional setup after loading the view.
    }

    @IBAction func onClickHome(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(viewController! , animated: true, completion: nil)
    }
    
    
    @IBAction func onClickCatagories(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "CatagoriesViewController")
        viewController?.modalPresentationStyle = .currentContext
        
        self.present(viewController! , animated: true, completion: nil)
    }
    @IBAction func onClickNewArivals(_ sender: Any) {
    }

    @IBAction func onClickTopDeals(_ sender: Any) {
    }
    @IBAction func onClickNotifications(_ sender: Any) {
    }
    @IBAction func onClickEditorPicks(_ sender: Any) {
    }
    @IBAction func onClickHelp(_ sender: Any) {
    }
}
