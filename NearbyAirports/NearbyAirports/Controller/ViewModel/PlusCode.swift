//
//  PlusCode.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct PlusCode : Mappable {
    var compound_code : String?
    var global_code : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        compound_code <- map["compound_code"]
        global_code <- map["global_code"]
    }
    
}
