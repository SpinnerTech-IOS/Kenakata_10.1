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
        navigationController?.addCustomBorderLine()
        addCustomItem()
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//            layout.minimumLineSpacing = 10
//            layout.minimumInteritemSpacing = 10
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//            let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 250)
//            layout.itemSize = size
//        }
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
