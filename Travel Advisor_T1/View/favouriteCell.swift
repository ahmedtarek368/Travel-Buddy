//
//  favouriteCell.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/20/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
class favouriteCell: UITableViewCell {

    @IBOutlet weak var favouriteImage: UIImageView!
    @IBOutlet weak var favouriteName: UITextView!
    @IBOutlet weak var favouriteRate: SwiftyStarRatingView!
    
    func setFavPlaces(place: Place){
        favouriteName.text = place.name
        favouriteImage.image = UIImage(data: place.imageData)
        favouriteImage.layer.cornerRadius = 8
        favouriteRate.value = CGFloat(place.rate.floatValue)
        
    }
}
