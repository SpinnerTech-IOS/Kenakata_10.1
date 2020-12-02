//
//  CustomSearchView.swift
//  Kenakata
//
//  Created by Md Sifat on 1/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit

class CustomSearchView: UIView {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setDesignfrotpview()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setDesignfrotpview()
        }
        func setDesignfrotpview(){
            layer.borderWidth = 0.5
            layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            layer.cornerRadius = 25
            clipsToBounds = true
        }
    
}
