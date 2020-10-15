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
        showAnimate()
        // Do any additional setup after loading the view.
    }
    @IBAction func Close_popupView(_ sender: Any) {
        removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
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
