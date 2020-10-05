//
//  CustomTextLbl.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

extension UITextField{
    func addRightImageView(image: UIImage){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = image
        rightView = imageView
        rightViewMode = .always
    }
    func addLeftImageView(icon: UIImage, placeholder: String) {
        let imageView = UIImageView()
        imageView.image = icon
        imageView.frame = CGRect(x: 0, y: 0, width: 17, height: 20)
        let view = UIView()
        view.frame = CGRect(x: 0, y: 2, width: 25, height: 25)
        view.backgroundColor = UIColor.clear
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
        self.placeholder = placeholder
    }
}
