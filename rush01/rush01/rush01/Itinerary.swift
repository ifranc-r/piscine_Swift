//
//  Itinerary.swift
//  rush01
//
//  Created by FRANC-REGIS Terence on 23/03/2019.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import Foundation
import CoreLocation
import GooglePlaces
import GoogleMaps

class ItinerayTask{
    
    let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    
    var selectedRoute: [String:Any]!
    
    var overviewPolyline: [String:AnyObject]!
    
    var originCoordinate: CLLocationCoordinate2D!
    
    var destinationCoordinate: CLLocationCoordinate2D!
    
    var originAddress: String!
    
    var destinationAddress: String!
    
    var routesArray : String!
    
    func getDirections(originId: String!, destinationID: String!, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: @escaping ((_ status: String, _ success: Bool) -> Void)) {
        if let originLocation = originId {
            if let destinationLocation = destinationID {
                let directionsURL = NSURL(string: baseURLDirections + "origin=place_id:" + originLocation + "&destination=place_id:" + destinationLocation + "&key=AIzaSyAGGWOdENmMMOWCqJ2_v6zK0_9KiJksdRg")
                URLSession.shared.dataTask(with: directionsURL! as URL) { (data, response, error) in
                        do {
                            if data != nil {
                                let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as!  [String:AnyObject]
                                print(dictionary)
                                let status = dictionary["status"] as! String
                                if status == "OK" {
//                                    self.selectedRoute = dictionary["routes"]! as! [String:Any][0] as! [String:Any]
//                                    self.overviewPolyline = self.selectedRoute["overview_polyline"] as [String:AnyObject]
//                                    
//                                    let legs = self.selectedRoute["legs"] as [String: Any]
//                                    
//                                    let startLocationDictionary = legs[0]["start_location"] as Dictionary<NSObject, AnyObject>
//                                    self.originCoordinate = CLLocationCoordinate2DMake(startLocationDictionary["lat"] as Double, startLocationDictionary["lng"] as Double)
//                                    
//                                    let endLocationDictionary = legs[legs.count - 1]["end_location"] as Dictionary<NSObject, AnyObject>
//                                    self.destinationCoordinate = CLLocationCoordinate2DMake(endLocationDictionary["lat"] as Double, endLocationDictionary["lng"] as Double)
//                                    
//                                    self.originAddress = legs[0]["start_address"] as String
//                                    self.destinationAddress = legs[legs.count - 1]["end_address"] as String

                                    self.routesArray = (((dictionary["routes"]!as! [Any])[0] as! [String:Any])["overview_polyline"] as! [String:Any])["points"] as! String
                                    print("routesArray: \(String(describing: self.routesArray))")
                                    completionHandler("Ok", true)
                                }
                            }
                            
                        } catch {
                            completionHandler("Error", false)
                    }
                    
                    }.resume()
            }
            else {
                completionHandler("Destination is nil.", false)
            }
        }
        else {
            completionHandler("Origin is nil", false)
        }
    }
}
    
extension URL {
        func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
            URLSession.shared
                .dataTask(with: self, completionHandler: completion)
                .resume()
        }
}
