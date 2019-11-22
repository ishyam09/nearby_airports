//
//  ViewPort.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct ViewPort : Mappable {
    var northeast : NorthEast?
    var southwest : SouthWest?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        northeast <- map["northeast"]
        southwest <- map["southwest"]
    }
    
}
