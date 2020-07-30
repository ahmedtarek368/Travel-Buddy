//
//  Place.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/20/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation
import UIKit

class Place {
    
    var name : String
    var phone : String
    var address : String
    var category : String
    var town : String
    var image : String
    var imageData : Data
    var rate : NSNumber
    var prices : NSNumber
    var coordinates : [NSNumber]
    var placeId : String
    
    init(name: String, phone: String, address: String, category: String, town: String, image: String, rate: NSNumber, prices: NSNumber, coordinates: [NSNumber], imageData: Data, placeId: String) {
        self.name = name
        self.phone = phone
        self.address = address
        self.category = category
        self.town = town
        self.image = image
        self.imageData = imageData
        self.rate = rate
        self.prices = prices
        self.coordinates = coordinates
        self.placeId = placeId
    }
}

