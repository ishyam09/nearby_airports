//
//  DataManager.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol DataManagerProtocol {
    func getNearByAirportList<T:Mappable>(completionHandler: @escaping (DataResponse<T>, _ success:Bool)->())
}

class DataManager: DataManagerProtocol {
    
    func getNearByAirportList<T:Mappable>(completionHandler: @escaping (DataResponse<T>, _ success:Bool)->()) {
        let url = UserManager.shared.generateURL()
        
        if Connectivity.isConnectedToInternet() {
            Alamofire.request(url, parameters: nil).responseObject { (response:  DataResponse<T>) in
                print(response)
                if (response.result.isSuccess) {
                    completionHandler(response , true)
                } else {
                    completionHandler(response, false)
                }
            }
        } else {
            let alert = UIAlertController(title: "", message: "The internet connection appears to be offline", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
}



extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
    
}
