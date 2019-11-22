//
//  Photos.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct Photos : Mappable {
    var height : Int?
    var html_attributions : [String]?
    var photo_reference : String?
    var width : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        height <- map["height"]
        html_attributions <- map["html_attributions"]
        photo_reference <- map["photo_reference"]
        width <- map["width"]
    }
    
}
