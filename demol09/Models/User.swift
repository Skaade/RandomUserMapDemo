//
//  User.swift
//  demol09
//
//  Created by dmu mac 25 on 01/03/2023.
//

import Foundation
import CoreLocation

struct User: Codable, Identifiable {
    let id = UUID().uuidString
    let name: Name
    let location: Location
    let picture: Picture
    
    struct Name: Codable{
        let title: String
        let first: String
        let last: String
    }
    struct Location: Codable {
        let coordinates: Coordinates
        
        struct Coordinates: Codable {
            //Computed propperty
            let latitude: String
            let longitude: String
        }
    }
    
    struct Picture: Codable{
        var large: String
        var medium: String
        var thumbnail: String
    }
    
   
}

extension User {
    var coordinates: CLLocationCoordinate2D {
        if let latitude = Double(location.coordinates.latitude),
           let longitude = Double(location.coordinates.longitude){
            
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return CLLocationCoordinate2D()
    }
}
