//
//  CustomHomeTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 6/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomHomeTableViewCell: UITableViewCell {


    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
