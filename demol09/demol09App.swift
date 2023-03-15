//
//  demol09App.swift
//  demol09
//
//  Created by dmu mac 25 on 01/03/2023.
//

import SwiftUI

@main
struct demol09App: App {
    
    @StateObject var stateController = StateController()
    @StateObject var locationController = LocationController()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateController)
                .environmentObject(locationController)
        }
    }
}
