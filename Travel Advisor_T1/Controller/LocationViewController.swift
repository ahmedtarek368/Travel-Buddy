//
//  location.swift
//  Travel Advisor_T1
//
//  Created by Abdelrahman elemam on 3/15/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var userLocationBtn: UIButton!
    @IBOutlet weak var mymap: MKMapView!
    
    var latitude = 28.5376138
    var longitude = 34.5155859
    var annotaionTitle = "Title"
    var viewOnUserLocation = false
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewOnDestinationLocation()
        let destination = CLLocation(latitude:latitude,longitude:longitude)
        let PointAnnotion = MKPointAnnotation()
        PointAnnotion.coordinate = destination.coordinate
        PointAnnotion.title = annotaionTitle
        PointAnnotion.subtitle="3-star hotel"
        mymap.addAnnotation(PointAnnotion)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    @IBAction func userLocationBtnAction(_ sender: Any) {
        if viewOnUserLocation == false{         //View User Location
            configureLocationServices()
            userLocationBtn.setImage(UIImage(named: "LocationOn.png"), for: .normal)
            viewOnUserLocation = true
        }else if viewOnUserLocation == true{        //View Destination Location
            centerViewOnDestinationLocation()
            locationManager.stopUpdatingLocation()
            userLocationBtn.setImage(UIImage(named: "LocationOff.png"), for: .normal)
            viewOnUserLocation = false
        }
    }
    
    func configureLocationServices(){
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }else if status == .authorizedAlways || status == .authorizedWhenInUse{
            mymap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        }
    }
    func centerViewOnDestinationLocation(){
        let destination = CLLocation(latitude:latitude,longitude:longitude)
        let region = MKCoordinateRegion(center:destination.coordinate,latitudinalMeters:500,longitudinalMeters:500)
        mymap.setRegion(region, animated: true)
    }
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let Region = MKCoordinateRegion.init(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            mymap.setRegion(Region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let locationCoordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let Region = MKCoordinateRegion.init(center: locationCoordinates, latitudinalMeters: 500, longitudinalMeters: 500)
        mymap.setRegion(Region, animated: true)
    }
    
    @IBAction func visionStyleSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            mymap.mapType = .standard
        }else{ mymap.mapType = .satellite}
    }
}
