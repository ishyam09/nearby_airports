//
//  AirportMarker.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 22/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import MapKit

class AirportMarker: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            clusteringIdentifier = "AirportCluster"
            glyphImage = #imageLiteral(resourceName: "plane")
            canShowCallout = false
            titleVisibility = .visible
        }
    }
    
}
