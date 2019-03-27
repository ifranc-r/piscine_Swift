//
//  ItinararyViewController.swift
//  rush01
//
//  Created by FRANC-REGIS Terence on 23/03/2019.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class ItinararyViewController: UIViewController {

    @IBOutlet weak var OrignTextField: UITextField!
    @IBOutlet weak var DestinationTextField: UITextField!
    var itinerary = ItinerayTask()
    var FieldSelected : UITextField?
    
    var originPlace : GMSPlace?
    var destinationPlace : GMSPlace?
    
    var tab : TabBarControllerCustum!
    var MapViewController: MapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OrignTextField?.addTarget(self, action: #selector(autocompleteClicked(textField:)), for: .touchDown)
        DestinationTextField?.addTarget(self, action: #selector(autocompleteClicked(textField:)), for: .touchDown)
        tab = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBarControllerCustum
        MapViewController = tab.viewControllers![0] as! MapViewController
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func autocompleteClicked(textField: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        // Take the field selected
        FieldSelected = textField
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func ItineraryButton(_ sender: Any) {
        itinerary.getDirections(originId: originPlace?.placeID, destinationID: destinationPlace?.placeID, waypoints: nil, travelMode: nil, completionHandler:{ (status, success) -> Void in
            if success {
                //Get tabBarController And MapViewController

                
                // Initiate RouteWay
                self.UseVal()
                // change tabBar to Maps view
                print("bravo")
            }
            else {
                print(status)
            }
        })
        //Get tabBarController And MapViewController
        
//        MapViewController.RouteWay = self.itinerary.routesArray
        tab.selectedIndex = 0
        self.present(tab, animated: true, completion: nil)
    }
    
    func UseVal(){
        if let routesArray = itinerary.routesArray{
            let path: GMSPath = GMSPath(fromEncodedPath: routesArray)!
        _ = GMSPolyline(path: path)
        tab.selectedIndex = 0
            self.present(tab, animated: true, completion: nil)
            
        }
        else{
            print("Nothing")
        }
    }
    
}

extension ItinararyViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        FieldSelected?.text = place.name
        
        switch FieldSelected!.restorationIdentifier! {
        case "origin":
            originPlace = place
        case "destination":
            destinationPlace = place
        default:
            print("no id")
        }
//        print("Place name: \(String(describing: place.name))")
//        print("Place ID: \(String(describing: place.placeID))")
//        print("Place coordinate: \(String(describing: place.coordinate))")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
