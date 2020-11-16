//
//  ReviewsViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 10/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        navigationController?.addCustomBorderLine()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Reviews"
        navigationController!.navigationBar.barStyle = UIBarStyle.black
        navigationController!.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

   
    @IBAction func onClickAddReview(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController")
        self.navigationController?.pushViewController(cartVC, animated: false)
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}
