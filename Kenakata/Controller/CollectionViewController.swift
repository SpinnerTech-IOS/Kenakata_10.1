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
    var parentCatagory : [ParentCatagory] = []
    var CatagoryTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.addCustomBorderLine()
        addCustomItem()
        collectionView.reloadData()
        navigationController!.navigationBar.topItem?.title = CatagoryTitle
        // Do any additional setup after loading the view.
    }


}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parentCatagory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionCollectionViewCell
        cell.parentCatagoryName.text = self.parentCatagory[indexPath.row].name
        return cell
    }
    
    
}
extension CollectionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoolectionTableViewCell
        return cell
    }
    
    
}
