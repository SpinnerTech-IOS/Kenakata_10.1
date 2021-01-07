//
//  CancelOrderTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 6/1/21.
//  Copyright © 2021 Md Sifat. All rights reserved.
//

import UIKit

class CancelOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
