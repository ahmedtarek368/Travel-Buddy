//
//  User.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/22/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var firstName : String
    var lastName : String
    var email : String
    
    init(firstName: String, lastName: String, email: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
