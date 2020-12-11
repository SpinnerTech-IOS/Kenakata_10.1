//
//  EmailValidationExtension.swift
//  Kenakata
//
//  Created by Md Sifat on 6/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import Foundation
import UIKit

extension String {

    var isValidPhoneNumber: Bool {
            let PHONE_REGEX = "^(?:\\+?88)?01[15-9]\\d{8}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            let result = phoneTest.evaluate(with: self)
            return result
        }

    
}
extension String {
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
