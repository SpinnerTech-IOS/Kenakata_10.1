//
//  CatagoriesViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 7/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CatagoriesViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
        let catagoryName = ["Men", "Women", "Kids", "Cosmetics", "Accessories", "Miscellaneous", "Watch"]
        let catagoryAmount = [22,66,0,7,10,99]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        // Do any additional setup after loading the view.
    }


}
extension CatagoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catagoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CatagoriesCollectionViewCell
        cell.catagoryNameLbl.text = catagoryName[indexPath.row]
//        if catagoryAmount[indexPath.row] == 0{
//            cell.catagoryAmountLbl.text = ""
//        }else{
            cell.catagoryAmountLbl.text = " 0 Items"
        
        return cell
        
    }
    
    
}
