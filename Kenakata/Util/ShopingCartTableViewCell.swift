//
//  ShopingCartTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 12/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class ShopingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityIncreaseLbl: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var quantitydecreaseBtn: UIButton!
    @IBOutlet weak var productImagemageView: CustomImageView!
    @IBOutlet weak var productNameTxtLbl: UILabel!
        @IBOutlet weak var priceTxtLbl: UILabel!
    @IBOutlet weak var deleteCartProductBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
