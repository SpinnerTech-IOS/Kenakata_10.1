//
//  GiftAndVoucherViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 5/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class GiftAndVoucherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.topItem?.title = "Gift & Voucher"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
