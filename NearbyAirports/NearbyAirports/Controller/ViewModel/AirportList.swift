//
//  AirportList.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct AirportList : Mappable {
    var html_attributions : [String]?
    var next_page_token : String?
    var results : [Results]?
    var status : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        html_attributions <- map["html_attributions"]
        next_page_token <- map["next_page_token"]
        results <- map["results"]
        status <- map["status"]
    }
    
}
