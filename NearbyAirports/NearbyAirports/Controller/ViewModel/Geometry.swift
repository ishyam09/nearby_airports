//
//  Geometry.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct Geometry : Mappable {
    var location : Location?
    var viewport : ViewPort?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        location <- map["location"]
        viewport <- map["viewport"]
    }
    
}
