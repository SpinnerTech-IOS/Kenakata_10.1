//
//  Onbrding2ViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 16/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class Onbrding2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickSkip(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signUpVC, animated: false)
    }
    
    @IBAction func onClicknext(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "Onbrding3ViewController")
        self.present(signUpVC, animated: false)
    }
    
    
}
