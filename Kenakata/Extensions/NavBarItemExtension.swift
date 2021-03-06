//
//  NavBarItemExtension.swift
//  Kenakata
//
//  Created by Md Sifat on 12/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

extension UIViewController{
    func hideKeyboardOntap(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismishKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismishKeyBoard(){
        view.endEditing(true)
    }
}
extension UIViewController{
    //Alert
    func notifyUser(message: String) -> Void {
     let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
     present(alert, animated: true, completion: nil)
     DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
      self.dismiss(animated: true)
     }
    }
    func addMenuBtn(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
               leftButton.setBackgroundImage(UIImage(named: "menu-icon"), for: .normal)
               leftButton.addTarget(self, action: #selector(leftButtonTouched), for: .touchUpInside)
         let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
         navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    func addCustomItem()
    {
        let realm = try! Realm()
        let cartDatas = realm.objects(CartDataModel.self)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        // badge label
        let label = UILabel(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont(name: "SanFranciscoText-Light", size: 10)
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.07323727757, green: 0.851349175, blue: 0.8049345016, alpha: 1)
        label.text = "\(cartDatas.count)"
        
        // button
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightButton.setBackgroundImage(UIImage(named: "cart-icon-1"), for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonTouched), for: .touchUpInside)
        rightButton.addSubview(label)
        
       
        
        // Bar button item
       
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
       
        navigationItem.rightBarButtonItem = rightBarButtomItem
    }
    @objc func rightButtonTouched() {
        let realm = try! Realm()
        // Retrieve
        let cartDatas = realm.objects(CartDataModel.self)
        if cartDatas.count != 0{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let cartVC = storyboard.instantiateViewController(withIdentifier: "ShoppingCartViewController")
            self.navigationController?.pushViewController(cartVC, animated: false)
        }else{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: "MyCartViewController")
        self.navigationController?.pushViewController(cartVC, animated: false)
        }
    }
    @objc func leftButtonTouched() {
        print("right button touched")
        let popvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        self.addChild(popvc)
        
        popvc.view.frame = self.view.frame
        
        self.view.addSubview(popvc.view)
        
        popvc.didMove(toParent: self)
    }
}
