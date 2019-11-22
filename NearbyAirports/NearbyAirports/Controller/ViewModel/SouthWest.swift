//
//  SouthWest.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct SouthWest : Mappable {
    var lat : Double?
    var lng : Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
}
