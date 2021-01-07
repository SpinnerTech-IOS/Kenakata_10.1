//
//  SingleToneManager.swift
//  Kenakata
//
//  Created by Md Sifat on 1/11/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit

final class SingleTonManager: NSObject {
    static let sharedInstance = SingleTonManager()
    static let BASE_URL = "https://afiqsouq.com/"
    static let OTP_user = "afiqsouq2021"
    static let OTP_pass = "12afiqsouq3434$"
    static let OTP_URL = "http://66.45.237.70/api.php?"
    static let Api_User = "consumer_key=ck_174c19562ef4a473934f3cec2eeeae1900662d2e"
    static let Api_Key = "consumer_secret=cs_799bcbd98605696b4a71eca9703f308fa5cd0dca"
   
    
    private override init() { }
    
    func apiKey() {}
}
