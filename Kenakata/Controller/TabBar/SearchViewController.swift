//
//  SearchViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 11/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import Realm
import AlamofireImage

class SearchViewController: UIViewController {


    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    let allPrdctUrl = "https://afiqsouq.com/wp-json/wc/v2/products?consumer_key=ck_62eed78870531071b419c0dca0b1dd9acf277227&consumer_secret=cs_a5b646ab7513867890dd63f2c504af98f00cee53"
    var allProduct : [AllProduct] = []
    var filteredallProduct : [AllProduct] = []
    var dataA = [[String: Any]]()
    var data : [String] = []
    
    var filteredData: [String]!
    
    func getData(){
        for i in 0..<allProduct.count{
             data.append(self.allProduct[i].name)
              
         }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        searchBar.delegate = self
        myCollectionView.delegate = self
        myCollectionView.dataSource = self

       filteredData = data
        print(data)
        Alamofire.request(allPrdctUrl).responseJSON { (myresponse) in
            switch myresponse.result{
            case .success:
                if let json = myresponse.result.value as? [[String: Any]] {

                    for i in 0..<json.count{
                        self.dataA.append(json[i])
                    }
                    for dic in self.dataA{
                        let allData = AllProduct.init(json: dic)
                        self.allProduct.append(allData)
                    }
                    self.getData()
                    self.myCollectionView.reloadData()
                    
                    
                }
                
            case let .failure(error):
                print(error)
                print("Wrong")
            }
        }
        
        if let layout = myCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(myCollectionView!.bounds.width-30)/2, height: 180)
            layout.itemSize = size
        }
        
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
        //cell.imageView.image = UIImage(named: "icon-bag")
        cell.productNameLbl.text = self.filteredData[indexPath.row]
        return cell
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        

        
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in

            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        myCollectionView.reloadData()
        
        
    }
    
}
