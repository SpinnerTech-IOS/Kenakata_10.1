//
//  WomensCoolectionTableViewCell.swift
//  Kenakata
//
//  Created by Md Sifat on 7/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CoolectionTableViewCell: UITableViewCell {


    @IBOutlet weak var collectionViewB: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CoolectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ccell = collectionViewB.dequeueReusableCell(withReuseIdentifier: "cbcell", for: indexPath) as! CollectionSecondCollectionViewCell
//        ccell.collectionViewBTextLbl.text = allProduct[indexPath.row].name
        return ccell
    }
    
    
}
