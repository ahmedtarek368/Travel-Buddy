//
//  recommendedCell.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/20/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class recommendedCell: UICollectionViewCell {
    
    @IBOutlet weak var recommendedName: UITextView!
    @IBOutlet weak var recommendedImage: UIImageView!
    @IBOutlet weak var recommendedRate: SwiftyStarRatingView!
    @IBOutlet weak var recommendedLocation: UITextField!
    @IBOutlet weak var recommendedCategory: UITextField!
    
    func setPlace(place: Place){
        recommendedName.text = place.name
        recommendedImage.image = UIImage(named: place.image)
        recommendedImage.layer.cornerRadius = 8
        recommendedRate.value = CGFloat(place.rate.floatValue)
        recommendedLocation.text = place.town
        recommendedCategory.text = place.category
    }
}
