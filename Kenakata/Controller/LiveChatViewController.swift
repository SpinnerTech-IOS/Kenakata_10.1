//
//  LiveChatViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 22/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import WebKit

class LiveChatViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.addCustomBorderLine()
        addCustomItem()
        navigationController!.navigationBar.topItem?.title = "Live Chat"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.webView.frame.size.height))
        self.view.addSubview(webView)
        let url = URL(string: "https://afiqsouq.com/faqs")
        webView.load(URLRequest(url: url!))
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }
    


}
