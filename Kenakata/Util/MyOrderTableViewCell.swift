//
//  MyOrderTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 2/1/21.
//  Copyright © 2021 Md Sifat. All rights reserved.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
