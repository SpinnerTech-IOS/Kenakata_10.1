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
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.addCustomBorderLine()
        addCustomItem()        // Do any additional setup after loading the view.
    }


}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath)
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
