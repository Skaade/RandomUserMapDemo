//
//  locationController.swift
//  GPSdemo
//
//  Created by dmu mac 25 on 10/03/2023.
//

import Foundation
import MapKit

class LocationController: NSObject, ObservableObject {
    
    @Published var coordinateRegion = MKCoordinateRegion()
    
    var locationManager: CLLocationManager?
    
    override init() {
        super.init() //Skal init først
        
        coordinateRegion.span = .init(latitudeDelta: 5, longitudeDelta: 5)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        checkLocationAuthorization()
    }
    
    deinit{
        locationManager?.stopUpdatingLocation()
    }
    
    public func checkLocationAuthorization(){
        guard let locationManager else {return}
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Unkown Error")
        }
        
    }
    
}

extension LocationController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinateRegion.center = locations.first!.coordinate
    }
}
