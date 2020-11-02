//
//  LiveChatViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 22/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

class LiveChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Live Chat"
       
        // Do any additional setup after loading the view.
    }
    


}
