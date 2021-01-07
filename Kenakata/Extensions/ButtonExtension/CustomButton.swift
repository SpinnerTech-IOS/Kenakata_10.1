//
//  CustomButton.swift
//  Kenakata
//
//  Created by Md Sifat on 5/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesignFrBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDesignFrBtn()
    }
    func setDesignFrBtn(){
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    
}
