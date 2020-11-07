//
//  CustomHomeCollectionViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 7/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomHomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colletionFeatureView: UIView!
    class var CustomCell : CustomHomeCollectionViewCell {
        let cell = Bundle.main.loadNibNamed("CustomHomeCollectionViewCell", owner: self, options: nil)?.last
        return cell as! CustomHomeCollectionViewCell
    }
    
    //call once successful loading of the cell
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.backgroundColor = UIColor.red
    }
    
}
