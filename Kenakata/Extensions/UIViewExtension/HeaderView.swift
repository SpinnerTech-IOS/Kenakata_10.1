//
//  HeaderView.swift
//  Kenakata
//
//  Created by Md Sifat on 10/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

protocol headerDelegate {
    func callHeader(index: Int)
}

class HeaderView: UIView {
    
    var Indx: Int?
    var delegate: headerDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var button : UIButton = {
        let button = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.titleLabel?.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        button.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    @objc func onClickHeaderView(){
        if let index = Indx{
            delegate?.callHeader(index: index)
        }
    }
    
}
