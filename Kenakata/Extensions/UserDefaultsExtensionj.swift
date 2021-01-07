//
//  UserDefaultsExtensionj.swift
//  Kenakata
//
//  Created by Md Sifat on 16/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension UserDefaults {
    
    func setLoggedIn(tokenText: JSON, userEmail: JSON, userName: JSON) {
        set(true, forKey: "isLoggedIn")
        set(String(describing: tokenText), forKey: "access_token")
        set(String(describing: userEmail), forKey: "access_email")
        set(String(describing: userName), forKey: "access_user")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        UIApplication.shared.keyWindow?.rootViewController = vc
        set(false, forKey: "isLoggedIn")
        set(nil, forKey: "access_token")
        set(nil, forKey: "access_email")
        set(nil, forKey: "access_pass")
        synchronize()
        
    }
    
    
}
