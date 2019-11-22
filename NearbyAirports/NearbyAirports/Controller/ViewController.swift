//
//  ViewController.swift
//  NearbyAirports
//
//  Created by Jeelakarra Shyam on 21/11/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mkMapView: MKMapView!
    
    private var locationsArray :Array <Results> = []
    private var dataManager = DataManager ()
    
    private let myLocation = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
        
        UserManager.shared.isLocationServiceEnabled { (isSuccess) in
            if isSuccess {
                self.setUserCurrentLocationToCentre()
                self.loadNearByAirports()
            }
        }
    }
    
    @IBAction func gotoMyLocation(_ sender: Any) {
      setUserCurrentLocationToCentre()
    }
    
    private func configureMap() {
        mkMapView.mapType = .standard
        mkMapView.isZoomEnabled = true
        mkMapView.isScrollEnabled = true
        mkMapView.showsUserLocation = true
        mkMapView.delegate = self
        mkMapView.register(AirportMarker.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mkMapView.register(AirportMarker.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
}

extension ViewController {
    
    private func setUserCurrentLocationToCentre() {
        guard let coordinate = UserManager.shared.locManager.location?.coordinate else { return }
        
        self.centerMapOnUserLocation(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    
    private func loadNearByAirports() {
        dataManager.getNearByAirportList { (response : DataResponse<AirportList>, isSuccesss) in
            guard let airportResults = response.value?.results else { return }
            
            let annotiatios = airportResults.map { (airportResult) -> MKAnnotation in
                let lat = airportResult.geometry?.location?.lat ?? 0
                let longi = airportResult.geometry?.location?.lng ?? 0
                
                let annotation:AirportPointAnnotation = AirportPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: longi)
                annotation.title = airportResult.name ?? ""
                annotation.airportDetail = airportResult
                
                return annotation
            }
            
            self.mkMapView.addAnnotations(annotiatios)
        }
    }
    
    private func loadCustomDetail(locationsArray: Array<Results>) {
        let views = Bundle.main.loadNibNamed("CustomDetail", owner: nil, options: nil)
        
        let calloutView = views?[0] as! CustomDetail
        calloutView.loadLocations(locationsArray: locationsArray)
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y:200)
        calloutView.tag = 200
        
        self.view.addSubview(calloutView)
    }
    
    private func centerMapOnUserLocation(lat: Double , lng: Double) {
        let mapCenter = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: mapCenter, span: MKCoordinateSpan(latitudeDelta: 0.400, longitudeDelta: 0.400))
        mkMapView.setRegion(region, animated: true)
        mkMapView.setCenter(mapCenter, animated: true)
        mkMapView.region = region
    }
    
    private func adjustSelectedAnotationToCenter()  {
        centerMapOnUserLocation(lat: self.locationsArray[0].geometry?.location?.lat ?? 0, lng: self.locationsArray[0].geometry?.location?.lng ?? 0)
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKClusterAnnotation {
            let annotation = annotation as! MKClusterAnnotation
            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ClusterResuseId")
            
            return view
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        
        if let annotation = view.annotation {
            if annotation is MKClusterAnnotation {
                self.locationsArray.removeAll()
                for locationAnnotation in (annotation as! MKClusterAnnotation).memberAnnotations {
                    if let loc = (locationAnnotation as! AirportPointAnnotation).airportDetail {
                        self.locationsArray.append(loc)
                    }
                }
                
                self.loadCustomDetail(locationsArray: self.locationsArray)
                adjustSelectedAnotationToCenter()
            } else {
                if let loc = (annotation as! AirportPointAnnotation).airportDetail{
                    self.locationsArray.removeAll()
                    self.locationsArray.append(loc)
                    
                    loadCustomDetail(locationsArray: self.locationsArray)
                    adjustSelectedAnotationToCenter()
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let viewWithTag = self.view.viewWithTag(200) {
            viewWithTag.isHidden = true
            viewWithTag.removeFromSuperview()
        }
    }
    
}

