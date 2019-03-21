//
//  ViewController.swift
//  rush01
//
//  Created by Inti FRANC-REGIS on 3/20/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate  {

    // initiate Views
    @IBOutlet weak var mapView: GMSMapView!
    
    // initiate Location Manager
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    
    //  default zoom level
    var zoomLevel: CLLocationDistance = 15.0
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    var nameLabel : String = ""
    var addressLabel : String = ""
    
    // Marker
    let marker = GMSMarker()
    
    // Autocomplite controler
    @IBOutlet weak var adressField: UITextField!
    var fetcher: GMSAutocompleteFetcher?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set bounds to inner-west Sydney Australia.
        let neBoundsCorner = CLLocationCoordinate2D(latitude: -33.843366,
                                                    longitude: 151.134002)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: -33.875725,
                                                    longitude: 151.200349)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)
         // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        // Create a new session token.
        let token: GMSAutocompleteSessionToken = GMSAutocompleteSessionToken.init()
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(bounds: bounds, filter: filter)
        fetcher?.delegate = self
        fetcher?.provide(token)
//        adressField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
//                             for: .editingChanged)
//        let placeholder = NSAttributedString(string: "Type a query...")
//        adressField?.attributedPlaceholder = placeholder
        
//        resultText = UITextView(frame: CGRect(x: 0, y: 65.0,
//                                              width: view.bounds.size.width,
//                                              height: view.bounds.size.height - 65.0))
//        resultText?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
//        resultText?.text = "No Results"
//        resultText?.isEditable = false
//
        // Geocalization
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter =  10
        locationManager.startUpdatingLocation()
        placesClient = GMSPlacesClient.shared()

        self.mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    @objc func textFieldDidChange(textField: UITextField) {
//        fetcher?.sourceTextHasChanged(textField.text!)
//    }

    @IBAction func GeoLocalisationButton(_ sender: UIButton) {
        let target = (locationManager.location?.coordinate)!
        let cam = GMSCameraUpdate.setTarget(target, zoom: 16.0)
        mapView.animate(with: cam)
    }
    func centerMapOnLocation(location: CLLocation) {
        let target = location.coordinate
        let cam = GMSCameraUpdate.setTarget(target)
        mapView.animate(with: cam)
        let zoomCamera = GMSCameraUpdate.zoom(by: 10.0)
        mapView.animate(with: zoomCamera)

    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
}





// AUTO COMPLITE
extension ViewController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        let resultsStr = NSMutableString()
        for prediction in predictions {
            resultsStr.appendFormat("\n Primary text: %@\n", prediction.attributedPrimaryText)
            resultsStr.appendFormat("Place ID: %@\n", prediction.placeID)
        }
        print(resultsStr)
//        resultText?.text = resultsStr as String
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}


