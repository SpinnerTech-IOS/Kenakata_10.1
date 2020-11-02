//
//  WishlistViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 22/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class WishlistViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Wish Lists"
        // Do any additional setup after loading the view.
    }
    
}

extension WishlistViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishlistTableViewCell
        return cell
    }

}
