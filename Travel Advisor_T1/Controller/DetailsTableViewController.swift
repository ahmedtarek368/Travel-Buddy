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
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var prices: SwiftyStarRatingView!
    @IBOutlet weak var favBtn: UIButton!

    var delegate:refreshFavourites?
    var place : Place = Place(name: "", phone: "", address: "", category: "", town: "", image: "", rate: 0, prices: 0, coordinates: [], imageData: .init(), placeId: "")
    var favourite = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if isAttributeExist(name: place.name) == true {
            favBtn.imageView?.image = UIImage(named: "filled heart")
        }else{
            favBtn.imageView?.image = UIImage(named: "empty heart")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if favourite == true {
            imageView.image = UIImage(data: place.imageData)
        }else{
            do{
                imageView.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://firebasestorage.googleapis.com/v0/b/travelbuddy-bf4d7.appspot.com/o/\(place.image)")! as URL))
            }catch{}
        }
        name.text = place.name
        rate.value = CGFloat(place.rate.floatValue)
        address.text =  "\(place.town), \(place.address)"
        prices.value = CGFloat(place.rate.floatValue)
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            let phoneNumAlert = UIAlertController(title: "Contact Numbers", message: place.phone, preferredStyle: .alert)
            phoneNumAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(phoneNumAlert, animated: true, completion: nil)
        }
        else if indexPath.row == 4{
            let Loc : LocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "Location") as! LocationViewController
            Loc.title="Location"
            Loc.annotaionTitle = place.name
            let temp :  Array<Double> = place.coordinates as! Array<Double>
            print(temp)
            Loc.latitude = temp[0]
            Loc.longitude = temp[1]
            self.navigationController?.pushViewController(Loc, animated: true)
        }
        else if indexPath.row == 5{
            let reviewsTVC : ReviewsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "reviewsTVC") as! ReviewsTableViewController
            reviewsTVC.placeId =  place.placeId
            self.navigationController?.pushViewController(reviewsTVC, animated: true)
        }
    }
    
    @IBAction func favBtnAction(_ sender: Any) {
        if isAttributeExist(name: place.name) == true{
            
            favBtn.imageView?.image = UIImage(named: "empty heart")
            CDDeletion(name: place.name)
            if favourite == true {
                let data = CDFetching()
                delegate?.refresh(places: data)
            }else{
                //let data = CDFetching()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshFav"), object: nil)
            }
            
        }
        else{
            favBtn.imageView?.image = UIImage(named: "filled heart")
            let rate : Float = Float(truncating: place.rate)
            let prices : Float = Float(truncating: place.prices)
            let coordinates :  Array<Double> = place.coordinates as! Array<Double>
            CDInsertion(name: place.name, rate: rate, prices: prices, phone: place.phone, coordinates: coordinates, Image: imageView.image!, address: place.address, town: place.town)
            if favourite == true {
                let data = CDFetching()
                delegate?.refresh(places: data)
            }else{
                //let data = CDFetching()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshFav"), object: nil)
            }
            
        }
    }
    
}
