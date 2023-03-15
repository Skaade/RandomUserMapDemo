//
//  StateController.swift
//  demol09
//
//  Created by dmu mac 25 on 01/03/2023.
//

import SwiftUI
import MapKit

class StateController: ObservableObject{
    @Published var users: [User] = []
    
    @Published var mapRect = MKMapRect()
    
    init(){
        guard let url = URL(string: "https://randomuser.me/api/?nat=DK&results=5") else {return}
        fetchUsers(url)
    }
    

    func fetchUsers(_ url: URL){
        Task(priority: .high){
            guard let rawUserData = await NetworkService.getData(url) else {return}
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode(RandomUserResult.self, from: rawUserData)
                users = result.results
            } catch {
                fatalError("Error Fetch Users")
            }
        }
    }
    
    func fit() {
            let points = users.map(\.coordinates).map(MKMapPoint.init)
            mapRect = points.reduce(MKMapRect.null){ rect, point in
                let newRect = MKMapRect(origin: point, size: MKMapSize())
                return rect.union(newRect)
            }
        }
    
}
