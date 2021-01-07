//
//  CompleteViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 20/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickShopNow(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: "main")
        self.present(cartVC, animated: false)
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
