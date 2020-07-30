//
//  reviewCell.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 7/29/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class reviewCell: UITableViewCell {


    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var rate: SwiftyStarRatingView!
    
    func roundedCornerImage(){
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
    }
    
    func setReviewData(review: Review, user: User){
        reviewTextView.text = review.textReview
        rate.value = CGFloat(truncating: review.rate)
        userName.text = "\(user.firstName) \(user.lastName)"
    }
}
