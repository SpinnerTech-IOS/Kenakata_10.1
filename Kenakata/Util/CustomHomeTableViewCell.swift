//
//  CustomHomeTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 6/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CustomHomeTableViewCell: UITableViewCell {


    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 170)
            layout.itemSize = size
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
