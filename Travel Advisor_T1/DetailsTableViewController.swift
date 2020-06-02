//
//  HotelDetailsTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 3/11/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class DetailsTableViewController: UITableViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rate: SwiftyStarRatingView!
    @IBOutlet weak var town: UITextField!

    var dic : Dictionary<String,Any>=[:]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            imageView.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://firebasestorage.googleapis.com/v0/b/travelbuddy-bf4d7.appspot.com/o/\(dic["image"] as! String)")! as URL))
        }catch{}
        name.text = dic["name"] as? String
        rate.value = dic["rate"] as! CGFloat
        town.text = dic["town"] as? String
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==2{
            let phoneNumAlert = UIAlertController(title: "Contact Numbers", message: dic["phone"] as? String, preferredStyle: .alert)
            phoneNumAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(phoneNumAlert, animated: true, completion: nil)
        }
        else if indexPath.row==4{
            let Loc : LocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "Location") as! LocationViewController
            Loc.title="Location"
            Loc.annotaionTitle = dic["name"] as! String
            let temp :  Array<Double> = dic["coordinates"] as! Array<Double>
            Loc.latitude = temp[0]
            Loc.longitude = temp[1]
            self.navigationController?.pushViewController(Loc, animated: true)
        }
    }
    

}
