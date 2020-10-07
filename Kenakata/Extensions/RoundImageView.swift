//
//  RoundImageView.swift
//  Kenakata
//
//  Created by Md Sifat on 7/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView{

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
            layer.borderColor = UIColor.black.cgColor
            layer.cornerRadius = frame.size.height/2
            clipsToBounds = true
    }
}
