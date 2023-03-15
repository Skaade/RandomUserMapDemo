//
//  SettingsView.swift
//  demol09
//
//  Created by dmu mac 25 on 10/03/2023.
//

import SwiftUI

struct SettingsView: View {
    
    //    @State var name: String = ""
    //    @State var description: String = ""
    @State var showLocation: Bool
    //    @State var isShowingAlert: Bool = false
    //    @State var isChanged: Bool = false
    
    @EnvironmentObject var locationController: LocationController
    
    
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        Form {
            Section(header: Text("Location")){
                Toggle("Show own location", isOn: $showLocation)
                    .onChange(of: showLocation) { newValue in
                        if newValue {
                            locationController.checkLocationAuthorization()
                        } else {
                            locationController.locationManager?.stopUpdatingLocation()
                        }
                        
                        
                    }
             
            }
                    Button {
                        dismiss()
                    } label: {
                        HStack{
                            Spacer()
                            Text("Save Changes")
                            Spacer()

                        }
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.title2)
                    .background(Color.accentColor)
                    .cornerRadius(8)
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showLocation: true).environmentObject(LocationController())
    }
}
