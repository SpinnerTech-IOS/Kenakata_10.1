//
//  ReviewsViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 10/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import AlamofireImage
import Realm
import RealmSwift

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var review1CountLbl: UILabel!
    @IBOutlet weak var review2CountLbl: UILabel!
    @IBOutlet weak var review3CountLbl: UILabel!
    @IBOutlet weak var review4CountLbl: UILabel!
    @IBOutlet weak var review5CountLbl: UILabel!
    @IBOutlet weak var reviewBasedOnCountLbl: UILabel!
    @IBOutlet weak var reviewAverageLbl: UILabel!
    var productId : Int?
    @IBOutlet weak var tableview: UITableView!
    
    var alReviews: [ReviewrModel] = []
    var alReview = [[String: Any]]()
    var avg = 0
    var ratingCount1 = 0
    var ratingCount2 = 0
    var ratingCount3 = 0
    var ratingCount4 = 0
    var ratingCount5 = 0
        let reviewUrl = SingleTonManager.BASE_URL + "wp-json/wc/v3/products/reviews?" + SingleTonManager.Api_User + "&" + SingleTonManager.Api_Key
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        navigationController?.addCustomBorderLine()
        addCustomItem()
        navigationController?.navigationBar.topItem?.title = "Reviews"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        getParentCatagoryJson()
        // Do any additional setup after loading the view.
    }

   func getParentCatagoryJson() {
       Alamofire.request(reviewUrl).responseJSON { (myresponse) in
           switch myresponse.result{
           case .success:
               if let json = myresponse.result.value as? [[String: Any]] {
                   for i in 0..<json.count{
                       let id = json[i]["product_id"] as! Int
                    if id == self.productId{
                           self.alReview.append(json[i])
                       }
                   }
                for alrvew in self.alReview{
                     let allData = ReviewrModel.init(json: alrvew)
                    self.alReviews.append(allData)
                }
                
                for i in 0..<self.alReviews.count{
                    
                    if (self.alReviews[i].rating == 5){
                        self.ratingCount5 = self.ratingCount5 + 1
                        self.review5CountLbl.text = String(self.ratingCount5)
                    }
                    if (self.alReviews[i].rating == 4){
                        self.ratingCount4 = self.ratingCount4 + 1
                        self.review4CountLbl.text = String(self.ratingCount4)
                    }
                    if (self.alReviews[i].rating == 3){
                        self.ratingCount3 = self.ratingCount3 + 1
                        self.review3CountLbl.text = String(self.ratingCount3)
                    }
                    if (self.alReviews[i].rating == 2){
                        self.ratingCount2 = self.ratingCount2 + 1
                        self.review2CountLbl.text = String(self.ratingCount2)
                    }
                    if (self.alReviews[i].rating == 1){
                        self.ratingCount1 = self.ratingCount1 + 1
                        self.review1CountLbl.text = String(self.ratingCount1)
                    }
                    self.avg = self.avg + self.alReviews[i].rating
                    self.reviewAverageLbl.text = String(Double(self.avg/self.alReviews.count))
                }
                self.reviewBasedOnCountLbl.text = "Based on " + String(self.alReviews.count) + "Review"
                   print(self.alReview.count)
                   
              
                   self.tableview.reloadData()
                   // self.collectionViewA.reloadData()
                   // self.collectionViewB.reloadData()
               }
               
           case let .failure(error):
               print(error)
               print("Wrong")
           }
       }
   }
    @IBAction func onClickAddReview(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addReviewVC = storyboard.instantiateViewController(withIdentifier: "AddAReviewViewController") as! AddAReviewViewController
        addReviewVC.productID = self.productId
        self.navigationController?.pushViewController(addReviewVC, animated: false)
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.alReviews.count == 0{
            return 0
        }
        return self.alReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewTableViewCell
        cell.reviewerName.text = self.alReviews[indexPath.row].reviewer
        cell.reviewRating.text = "(" + String(self.alReviews[indexPath.row].rating) + ")"
        cell.reviewCmnt.text = self.alReviews[indexPath.row].review?.html2String
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
