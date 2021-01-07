//
//  CustomImageView.swift
//  Kenakata
//
//  Created by Md Sifat on 8/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeRounded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeRounded()
    }
    func makeRounded() {

        layer.cornerRadius = 15
        clipsToBounds = true
    }
}
