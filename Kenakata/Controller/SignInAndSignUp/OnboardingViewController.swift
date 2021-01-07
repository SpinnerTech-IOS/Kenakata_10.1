//
//  OnboardingViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 15/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit


class OnboardingViewController: UIViewController {
    
    
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
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "OnbrdingOneViewController")
        self.present(signUpVC, animated: false)
    }
    
}
