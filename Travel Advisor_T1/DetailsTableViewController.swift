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
    var dic : Dictionary<String,Any>=[:]
    var favourite = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if isAttributeExist(name: dic["name"] as! String) == true {
            favBtn.imageView?.image = UIImage(named: "filled heart")
        }else{
            favBtn.imageView?.image = UIImage(named: "empty heart")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if favourite == true {
            imageView.image = UIImage(data: dic["image"] as! Data)
        }else{
            do{
                imageView.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://firebasestorage.googleapis.com/v0/b/travelbuddy-bf4d7.appspot.com/o/\(dic["image"] as! String)")! as URL))
            }catch{}
        }
        name.text = dic["name"] as? String
        rate.value = dic["rate"] as! CGFloat
        address.text =  "\(dic["town"] ?? "0"), \(dic["address"] ?? "0")"
        prices.value = dic["prices"] as! CGFloat
        
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
    
    @IBAction func favBtnAction(_ sender: Any) {
        if isAttributeExist(name: dic["name"] as! String) == true{
            
            favBtn.imageView?.image = UIImage(named: "empty heart")
            CDDeletion(name: dic["name"] as! String)
            if favourite == true {
                let data = CDFetching()
                delegate?.refresh(data: data)
            }else{
                //let data = CDFetching()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshFav"), object: nil)
            }
            
        }
        else{
            favBtn.imageView?.image = UIImage(named: "filled heart")
            let rate : Float = Float(truncating: dic["rate"] as! NSNumber)
            let prices : Float = Float(truncating: dic["prices"] as! NSNumber)
            let coordinates :  Array<Double> = dic["coordinates"] as! Array<Double>
            CDInsertion(name: dic["name"] as! String, rate: rate, prices: prices, phone: dic["phone"] as! String, coordinates: coordinates, Image: imageView.image!, address: dic["address"] as! String, town: dic["town"] as! String)
            if favourite == true {
                let data = CDFetching()
                delegate?.refresh(data: data)
            }else{
                //let data = CDFetching()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshFav"), object: nil)
            }
            
        }
    }
    
}
