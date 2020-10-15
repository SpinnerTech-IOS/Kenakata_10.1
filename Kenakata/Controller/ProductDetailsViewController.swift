//
//  ProductDetailsViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Product Details"
        navigationController!.navigationBar.barStyle = UIBarStyle.black
        navigationController!.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickReview(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: "MyCartViewController")
        self.navigationController?.pushViewController(cartVC, animated: false)
    }
    
}
