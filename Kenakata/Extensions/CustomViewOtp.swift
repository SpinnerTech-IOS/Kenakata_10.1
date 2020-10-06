//
//  CustomViewOtp.swift
//  Kenakata
//
//  Created by Md Sifat on 6/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomViewOtp: UIView {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setDesignfrotpview()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setDesignfrotpview()
        }
        func setDesignfrotpview(){
            layer.borderWidth = 1
            layer.borderColor = #colorLiteral(red: 0.09960857766, green: 1, blue: 0.9294861437, alpha: 1)
            layer.cornerRadius = 12
            clipsToBounds = true
        }
    
}
