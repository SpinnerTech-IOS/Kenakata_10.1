//
//  MyWalletTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 5/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class MyWalletTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
