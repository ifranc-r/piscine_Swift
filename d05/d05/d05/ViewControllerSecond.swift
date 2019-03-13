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
class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}
class ViewControllerSecond: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 100
    var initialLocation = CLLocation()
    var annotationsData : [MyPointAnnotation] = []
    var centerAnnotation : MyPointAnnotation? {
        didSet{
            let coord = centerAnnotation?.coordinate
            centerMapOnLocation(location: CLLocation(latitude: (coord?.latitude)!, longitude: (coord?.longitude)!))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLocation = CLLocation(latitude: 48.896734, longitude: 2.318469)
        centerMapOnLocation(location: initialLocation)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter =  10
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        self.mapView.showsUserLocation = true
        placeData()
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
    func select_annotation(index: Int){
        centerAnnotation = annotationsData[index]
    }
    
    func placeData(){
        let tab = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarControllerCustum
        let locations = tab.locations_data
        for location in locations {
            let annotation = MyPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.0, longitude: location.1)
            annotation.title = location.2
            annotation.subtitle = location.3
            annotation.pinTintColor = location.4
            mapView.addAnnotation(annotation)
            annotationsData.append(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
        }
        
        return annotationView
    }
}
