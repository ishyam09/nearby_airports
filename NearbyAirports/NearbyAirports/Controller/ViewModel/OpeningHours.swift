//
//  OpeningHours.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct OpeningHours : Mappable {
    var open_now : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        open_now <- map["open_now"]
    }
    
}
