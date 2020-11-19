//
//  MyCartViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController {
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        addMenuBtn()
        navigationController!.navigationBar.topItem?.title = "My Cart"
        navigationController!.navigationBar.barStyle = UIBarStyle.black
        navigationController!.navigationBar.tintColor = UIColor.white        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickShopNow(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(cartVC, animated: false)
    }
    
}
