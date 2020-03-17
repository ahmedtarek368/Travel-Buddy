//
//  location.swift
//  Travel Advisor_T1
//
//  Created by Abdelrahman elemam on 3/15/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import MapKit
class LocationViewController: UIViewController {
    @IBAction func segment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            mymap.mapType = .standard
        }else{ mymap.mapType = .satellite}
    }
    @IBOutlet weak var mymap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let applehq = CLLocation(latitude:37.334722,longitude:-122.008889)
        let regionRadius:CLLocationDistance=1000.0
        let region = MKCoordinateRegion(center:applehq.coordinate,latitudinalMeters:regionRadius,longitudinalMeters:regionRadius)
        mymap.setRegion(region, animated: true)
        let PointAnnotion = MKPointAnnotation()
        PointAnnotion.coordinate = applehq.coordinate
        PointAnnotion.title="Apple HQ"
        PointAnnotion.subtitle="here"
        mymap.addAnnotation(PointAnnotion)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LocationViewController:MKMapViewDelegate{
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("rendring")
    }
    
    
    
}
