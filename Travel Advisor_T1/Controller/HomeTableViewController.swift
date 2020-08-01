//
//  HomeTableViewController.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 2/3/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import MapKit
import SwiftyStarRatingView
import Firebase

class HomeTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, selectCity {
    
    
    @IBOutlet weak var whereToBtnOutlet: UIButton!
    @IBOutlet var homeTableView: UITableView!
    @IBOutlet weak var categoryCollView: UICollectionView!
    @IBOutlet weak var recommendCollView: UICollectionView!
    @IBOutlet weak var nearbyCollView: UICollectionView!
    
    var locationManager = CLLocationManager()
    var nearbyPlaces: [Place] = []
    let recommendPlaces: [Place] = []
    
    let categoryImgArr = ["Ticket2-2.png","Mountain.png","Hotel2-1.png","Restaurant-1.png"]
    let categoryArr = ["Things to Do","Attractions","Hotels","Restaurants"]
    
    override func viewDidLayoutSubviews() {
        whereToBtnOutlet.layer.cornerRadius = whereToBtnOutlet.frame.height/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "HOME", style: .plain, target: nil, action:nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        if configureLocationServices() == true {
            let userLocation = locationManager.location?.coordinate
            
            if userLocation != nil {
                print(userLocation!)
                let userCoordinates = CLLocation(latitude: userLocation!.latitude, longitude: userLocation!.longitude)
                readNearbyData(userCoordinates: userCoordinates, completion: {(nearbyPlaces) in
                    self.nearbyPlaces =  nearbyPlaces
                    self.homeTableView.reloadData()
                    self.nearbyCollView.reloadData()
                })
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locationManager.location?.coordinate
        print(location!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == recommendCollView){
            return recommendPlaces.count
        }
        else if(collectionView == nearbyCollView){
            return nearbyPlaces.count
        }
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == recommendCollView){
            let place = recommendPlaces[indexPath.row]
            let cell = recommendCollView.dequeueReusableCell(withReuseIdentifier: "recCell", for: indexPath) as! recommendedCell
            cell.setPlace(place: place)
            return cell
        }
            
        else if(collectionView == nearbyCollView){
            let place = nearbyPlaces[indexPath.row]
            let cell = nearbyCollView.dequeueReusableCell(withReuseIdentifier: "nearbyCell", for: indexPath) as! nearbyCell
            cell.setPlace(place: place)
            return cell
        }
        
        // if (collectionView == categoryCollView)
        let cell = categoryCollView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath)
        let catImg :UIImageView = cell.viewWithTag(1) as! UIImageView
        catImg.image = UIImage(named:categoryImgArr[indexPath.row])
        let catTextView :UITextView = cell.viewWithTag(2) as! UITextView
        catTextView.textContainer.maximumNumberOfLines = 2
        catTextView.textContainer.lineBreakMode = .byClipping
        catTextView.text = categoryArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == categoryCollView){
            if whereToBtnOutlet.currentTitle == "Where to?"{
                let selectCityAlert = UIAlertController(title: "Undefined Destination", message: "Please Select Where to", preferredStyle: .alert)
                selectCityAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(selectCityAlert, animated: true, completion: nil)
            }
            else{
                let ResListTVC : ResultListTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "RLTVC") as! ResultListTableViewController
                if indexPath.row==2{
                    ResListTVC.title="Hotels"
                    readData(town: whereToBtnOutlet.currentTitle!, category: "Hotels", completion: {(places) in ResListTVC.places=places
                        self.navigationController?.pushViewController(ResListTVC, animated: true)})
                }
                if indexPath.row==0{
                    ResListTVC.title="Things to do"
                    readData(town: whereToBtnOutlet.currentTitle!, category: "Things to do", completion: {(places) in ResListTVC.places=places
                        self.navigationController?.pushViewController(ResListTVC, animated: true)})
                }
                if indexPath.row==1{
                    ResListTVC.title="Attractions"
                    readData(town: whereToBtnOutlet.currentTitle!, category: "Attractions", completion: {(places) in ResListTVC.places=places
                        self.navigationController?.pushViewController(ResListTVC, animated: true)})
                }
                if indexPath.row==3{
                    ResListTVC.title="Restaurants"
                    readData(town: whereToBtnOutlet.currentTitle!, category: "Restaurants", completion: {(places) in ResListTVC.places=places
                        self.navigationController?.pushViewController(ResListTVC, animated: true)})
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if(collectionView == recommendCollView) || (collectionView == nearbyCollView){
            return 9.0
        }
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(collectionView == categoryCollView){
            let height : CGFloat = self.categoryCollView.frame.size.height
            let width : CGFloat = self.categoryCollView.frame.size.width
            return CGSize(width: width * 0.2475 , height: height * 0.92 )
        }
            
        else if(collectionView == nearbyCollView){
            let height : CGFloat = self.nearbyCollView.frame.size.height
            let width : CGFloat = self.nearbyCollView.frame.size.width
            return CGSize(width: width * 0.89 , height: height )
        }
        
        // if (collectionView == recommendCollView)
        let height : CGFloat = self.recommendCollView.frame.size.height
        let width : CGFloat = self.recommendCollView.frame.size.width
        return CGSize(width: width * 0.89 , height: height )
    }
    
    func selectCity(city: String) {
        whereToBtnOutlet.setTitle(city, for: .normal)
    }
    
    @IBAction func whereToBtnAction(_ sender: Any) {
        let citiesTVC : CitiesTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "citiesTVC") as! CitiesTableViewController
        citiesTVC.delegate = self
        self.present(citiesTVC, animated: true, completion: nil)
    }
    
    @IBAction func deselectCityBtn(_ sender: Any) {
        whereToBtnOutlet.setTitle("Where to?", for: .normal)
    }
    
    func configureLocationServices() -> Bool{
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            return true
        }
        locationManager.requestAlwaysAuthorization()
        return false
    }
    
    func readNearbyData(userCoordinates: CLLocation, completion: @escaping (_ data: [Place]) -> ()){
        
        var nearbyPlaces : [Place] = []
        let db = Firestore.firestore()
        db.collection("Places").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let docData = document.data()
                        
                        let coordinates : [Double] = docData["coordinates"]! as! [Double]
                        let destination = CLLocation(latitude:coordinates[0],longitude:coordinates[1])
                        let distance = userCoordinates.distance(from: destination)
                        if distance <= 16093.4 {
                            nearbyPlaces.append(Place(name: docData["name"]! as! String,
                                                phone: docData["phone"]! as! String,
                                                address: docData["address"]! as! String,
                                                category: docData["category"]! as! String,
                                                town: docData["town"]! as! String,
                                                image: docData["image"]! as! String,
                                                rate: docData["rate"]! as! NSNumber ,
                                                prices: docData["prices"]! as! NSNumber,
                                                coordinates: docData["coordinates"]! as! [NSNumber],
                                                imageData: .init(),
                                                placeId: docData["pid"]! as! String))
                        }
                    }
                    //return places data
                    completion(nearbyPlaces)
                }
        }
    }
    // MARK: - Table view data source
    
}

