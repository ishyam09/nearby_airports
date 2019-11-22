//
//  Results.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import ObjectMapper

struct Results : Mappable {
    var geometry : Geometry?
    var icon : String?
    var id : String?
    var name : String?
    var opening_hours : OpeningHours?
    var photos : [Photos]?
    var place_id : String?
    var plus_code : PlusCode?
    var rating : Double?
    var reference : String?
    var scope : String?
    var types : [String]?
    var user_ratings_total : Int?
    var vicinity : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        geometry <- map["geometry"]
        icon <- map["icon"]
        id <- map["id"]
        name <- map["name"]
        opening_hours <- map["opening_hours"]
        photos <- map["photos"]
        place_id <- map["place_id"]
        plus_code <- map["plus_code"]
        rating <- map["rating"]
        reference <- map["reference"]
        scope <- map["scope"]
        types <- map["types"]
        user_ratings_total <- map["user_ratings_total"]
        vicinity <- map["vicinity"]
    }
    
}
