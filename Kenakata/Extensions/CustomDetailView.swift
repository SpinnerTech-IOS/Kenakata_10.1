//
//  CustomDetailView.swift
//  Kenakata
//
//  Created by Md Sifat on 9/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesignFrBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDesignFrBtn()
    }
    func setDesignFrBtn(){
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 15
        clipsToBounds = true
    }

}
