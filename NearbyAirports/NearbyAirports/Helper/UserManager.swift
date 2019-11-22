//
//  UserManager.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import UIKit
import CoreLocation

class UserManager: NSObject,CLLocationManagerDelegate {
    
    static let shared = {
        return UserManager()
    }()
    
    let locManager = CLLocationManager()
    var completionHandler: ((_ isSuccess: Bool) -> ())!
    
    let apiKey = "AIzaSyDPzYuM14HQkOPQ2V-9oz-8zz8pBZvR868"
    
    func generateURL() -> String {
        guard let currentLocation = UserManager.shared.locManager.location else {
            return ""
        }
        
        let user_lat = String(format: "%f", currentLocation.coordinate.latitude)
        let user_long = String(format: "%f", currentLocation.coordinate.longitude)
        
        return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + user_lat + "," + user_long + "&radius=100000&keyword=airport&key=" + apiKey
    }
    
    func isLocationServiceEnabled(completionHandler: @escaping (_ success:Bool)->()) {
        self.locManager.delegate = self
        self.locManager.requestAlwaysAuthorization()
        self.locManager.requestWhenInUseAuthorization()
        self.completionHandler = completionHandler
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedAlways || status == .authorizedWhenInUse) {
            self.completionHandler(true)
        } else if(status == .denied) {
            self.completionHandler(false)
        }
    }
    
}
