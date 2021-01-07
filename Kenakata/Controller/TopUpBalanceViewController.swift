//
//  TopUpBalanceViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 27/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class TopUpBalanceViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    var cID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickPayWithSSLCOmmerz(_ sender: Any) {
    }
    
    @IBAction func onClickGoBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "main")
        self.present(collectionVC, animated: false)
    }
}
