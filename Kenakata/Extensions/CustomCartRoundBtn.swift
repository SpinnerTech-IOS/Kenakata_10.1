//
//  CustomCartRoundBtn.swift
//  Kenakata
//
//  Created by Md Sifat on 8/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit

class CustomCartRoundBtn: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeRounded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeRounded()
    }
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
    }
}
