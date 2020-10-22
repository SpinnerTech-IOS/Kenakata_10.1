//
//  WomensCollectionViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 7/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var collectionView: UICollectionView!
    var parentCatagory = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.addCustomBorderLine()
        addCustomItem()
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }


}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parentCatagory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionCollectionViewCell
        cell.parentCatagoryName.text = self.parentCatagory[indexPath.row]["name"] as? String
        return cell
    }
    
    
}
//extension WomensCollectionViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}
