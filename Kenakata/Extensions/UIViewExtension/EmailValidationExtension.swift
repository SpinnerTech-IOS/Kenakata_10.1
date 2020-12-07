//
//  EmailValidationExtension.swift
//  Kenakata
//
//  Created by Md Sifat on 6/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
}
