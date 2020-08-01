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
        
        centerViewOnDestinationLocation(lat: latitude, long: longitude)
        let destination = CLLocation(latitude:latitude,longitude:longitude)
        let PointAnnotion = MKPointAnnotation()
        PointAnnotion.coordinate = destination.coordinate
        PointAnnotion.title = annotaionTitle
        PointAnnotion.subtitle="3-star hotel"
        mymap.addAnnotation(PointAnnotion)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    @IBAction func getUserLocationTapped(_ sender: Any) {
        if viewOnUserLocation == false{         //View User Location
            if configureLocationServices() == true {
                mymap.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                userLocationBtn.setImage(UIImage(named: "LocationOn.png"), for: .normal)
                viewOnUserLocation = true
            }
        }else if viewOnUserLocation == true{        //View Destination Location
            centerViewOnDestinationLocation(lat: latitude, long: longitude)
            locationManager.stopUpdatingLocation()
            userLocationBtn.setImage(UIImage(named: "LocationOff.png"), for: .normal)
            viewOnUserLocation = false
        }
    }
    
    @IBAction func getDirectionsTapped(_ sender: Any) {
        getDirections()
    }
    
    func configureLocationServices() -> Bool{
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            return true
        }
        locationManager.requestAlwaysAuthorization()
        return false
    }
    
    func centerViewOnDestinationLocation(lat: Double, long: Double){
        let destination = CLLocation(latitude:lat,longitude:long)
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
    
    func getDirections(){
        if configureLocationServices() == true {
            guard let Location = locationManager.location?.coordinate else { return }
            
            let request = createDirectionsRequest(from: Location)
            let directions = MKDirections(request: request)
            
            directions.calculate{ [unowned self] (response, error) in
                guard let response = response else { return }
                
                for route in response.routes{
                    self.mymap.addOverlay(route.polyline)
                    self.mymap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
        }
    }
    
    func createDirectionsRequest(from coordinate:CLLocationCoordinate2D) -> MKDirections.Request{
        let destinationCoordinate = CLLocationCoordinate2D(latitude:latitude,longitude:longitude)
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        
        return renderer
    }
    
    @IBAction func visionStyleSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            mymap.mapType = .standard
        }else{ mymap.mapType = .satellite}
    }
}
