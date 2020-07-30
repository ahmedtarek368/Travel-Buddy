//
//  Review.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/29/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation

class Review {
    
    var userId : String
    var placeId : String
    var textReview : String
    var rate : NSNumber
    
    init(userId: String, placeId: String, textReview: String, rate: NSNumber){
        self.userId = userId
        self.placeId = placeId
        self.textReview = textReview
        self.rate = rate
    }
}
