//
//  resultPlaceCell.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/20/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class resultPlaceCell: UITableViewCell {

    @IBOutlet weak var resultPlaceImage: UIImageView!
    @IBOutlet weak var resultPlaceName: UITextView!
    @IBOutlet weak var resultPlaceRate: SwiftyStarRatingView!
    
    func setResultPlaces(place: Place){
        resultPlaceName.text = place.name
        do{
            resultPlaceImage.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://firebasestorage.googleapis.com/v0/b/travelbuddy-bf4d7.appspot.com/o/\(place.image)")! as URL))
        }catch{}
        resultPlaceImage.layer.cornerRadius = 8
        resultPlaceRate.value = CGFloat(place.rate.floatValue)
        
    }
}
