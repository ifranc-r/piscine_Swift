//
//  ViewControllerSecond.swift
//  d05
//
//  Created by Inti FRANC-REGIS on 2/28/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewControllerSecond: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 100
    var initialLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLocation = CLLocation(latitude: 48.896734, longitude: 2.318469)
        centerMapOnLocation(location: initialLocation)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 48.896734, longitude: 2.318469)
        annotation.title = "ecole 42"
        annotation.subtitle = "One day I'll go here..."
        mapView.addAnnotation(annotation)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter =  10
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }

    @IBAction func SegmetedControlEvent(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            mapView.mapType = .standard
        }
        else if (sender.selectedSegmentIndex == 1) {
            mapView.mapType = .satellite
        }
        else {
            mapView.mapType = .hybrid
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GeoLocalisationButton(_ sender: UIButton) {
        let coordinates = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
