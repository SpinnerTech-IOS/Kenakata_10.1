//
//  CustomerData.swift
//  Kenakata
//
//  Created by Md Sifat on 13/10/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation

class CustomerData{
    var userName: String?
    var userEmail = String()
    var userPassword = String()
    
    init(userName: String, userEmail: String, userPassword: String) {
        self.userName = userName
        self.userEmail = userEmail
        self.userPassword = userPassword
    }
}
