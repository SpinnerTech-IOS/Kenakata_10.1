//
//  SearchViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {


    @IBOutlet var collectionView: UICollectionView!
    
    
    @IBOutlet var searchBar: UISearchBar!
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        filteredData = data
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 250)
            layout.itemSize = size
        }
        
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! SearchCollectionViewCell
        //cell.imageView.image = UIImage(named: "icon-bag")
        cell.dataNameLbl.text = filteredData[indexPath.row]
        return cell
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        collectionView.reloadData()
    }
    
}
