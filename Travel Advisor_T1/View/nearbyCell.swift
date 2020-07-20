//
//  nearbyCell.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/20/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class nearbyCell: UICollectionViewCell {
    
    @IBOutlet weak var nearbyName: UITextView!
    @IBOutlet weak var nearbyImage: UIImageView!
    @IBOutlet weak var nearbyRate: SwiftyStarRatingView!
    @IBOutlet weak var nearbyLocation: UITextField!
    @IBOutlet weak var nearbyCategory: UITextField!
    
    func setPlace(place: Place){
        nearbyName.text = place.name
        nearbyImage.image = UIImage(named: place.image)
        nearbyImage.layer.cornerRadius = 8
        nearbyRate.value = CGFloat(place.rate.floatValue)
        nearbyLocation.text = place.town
        nearbyCategory.text = place.category
    }
}
