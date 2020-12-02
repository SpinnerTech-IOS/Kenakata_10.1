//
//  NavigationBarExtension.swift
//  Kenakata
//
//  Created by Md Sifat on 12/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController
{

    func addCustomBorderLine(color: UIColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1),height:Double = 1)
    {
       // navigationBar.barTintColor = UIColor(named: "landingPage_BackgroundColor")

        navigationBar.setValue(true, forKey: "hidesShadow")
        
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        
        //Creating New line
//        let topLineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
//        topLineView.backgroundColor = color
//        navigationBar.addSubview(topLineView)
//        
//        topLineView.translatesAutoresizingMaskIntoConstraints = false
//        topLineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
//        topLineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
//        topLineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
//        topLineView.topAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
    }

        
}
