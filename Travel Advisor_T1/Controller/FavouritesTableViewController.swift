//
//  FavouritesTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 6/2/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class FavouritesTableViewController: UITableViewController,refreshFavourites {
    
    @IBOutlet var favTableView: UITableView!
    var places : [Place] = []
    let favourite = true
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshFav(_:)), name: Notification.Name(rawValue: "refreshFav"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.places = CDFetching()
        favTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! favouriteCell
        let place = places[indexPath.row]
        cell.setFavPlaces(place: place)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DTVC : DetailsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "DTVC") as! DetailsTableViewController
        let place = places[indexPath.row]
        DTVC.place = place
        DTVC.delegate = self
        DTVC.favourite = self.favourite
        self.navigationController?.pushViewController(DTVC, animated: true)
    }
    
    func refresh(places: [Place]) {
        self.places = places
        favTableView.reloadData()
    }
    
    @objc func refreshFav(_ notification: Notification) {
        self.places = CDFetching()
        favTableView.reloadData()
    }

}
