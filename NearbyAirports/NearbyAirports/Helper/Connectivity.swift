//
//  Connectivity.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 23/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
