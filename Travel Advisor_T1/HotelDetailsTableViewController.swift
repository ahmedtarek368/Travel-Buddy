//
//  HotelDetailsTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 3/11/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
class HotelDetailsTableViewController: UITableViewController {
        
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==4{
            let Loc : LocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "Location") as! LocationViewController
            Loc.title="Location"
            self.navigationController?.pushViewController(Loc, animated: true)
        }
    }
    

}
