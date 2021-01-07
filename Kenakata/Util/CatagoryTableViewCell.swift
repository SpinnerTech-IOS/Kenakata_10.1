//
//  CatagoryTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 21/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CatagoryTableViewCell: UITableViewCell {
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
