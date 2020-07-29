//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textfield.frame.size.height - 2 , width: 0, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 42/255, green: 124/255, blue: 81/255, alpha: 1).cgColor
        
        // Remove border on text field
        //textfield.borderStyle = .none
        
        // Add the line to the text field
        //textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 42/255, green: 124/255, blue: 81/255, alpha: 1)
        button.layer.cornerRadius = 15
        //button.tintColor = UIColor.white
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    static func styleSkipButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(red: 42/255, green: 124/255, blue: 81/255, alpha: 1).cgColor
        button.layer.cornerRadius = 15
    }
    
    static func styleCancelButton(_ button:UIButton) {
        
        // Cancel rounded corner style
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(red: 255/255, green: 59/255, blue: 48/255, alpha: 1).cgColor
        button.layer.cornerRadius = 15
    }
    
    static func hideButton(_ button:UIButton) {
        
        // Cancel rounded corner style
        button.layer.borderWidth = 0
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
