//
//  ReviewTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 9/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

  
    @IBOutlet weak var reviewCmnt: UILabel!
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var reviewerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
