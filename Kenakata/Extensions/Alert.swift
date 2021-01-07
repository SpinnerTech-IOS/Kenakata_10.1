//
//  Alert.swift
//  Kenakata
//
//  Created by Md Sifat on 6/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    class func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
