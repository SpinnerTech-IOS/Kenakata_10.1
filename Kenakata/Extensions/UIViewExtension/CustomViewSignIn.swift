//
//  CustomViewSignIn.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomViewSignIn: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeView()
    }
    
   func  customizeView(){
    layer.borderWidth = 0.5
    layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    layer.cornerRadius = 15
    clipsToBounds = true
    }
}
