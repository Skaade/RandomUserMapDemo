//
//  UserDetailView.swift
//  demol09
//
//  Created by dmu mac 25 on 01/03/2023.
//

import SwiftUI
import MapKit

struct UserDetailView: View {
    
    @EnvironmentObject var stateController: StateController
    @EnvironmentObject var locationController: LocationController
    
    @Environment(\.presentationMode) var presentationMode

    
    var user: User
    
    @State var region: MKCoordinateRegion
    @State var isSettingsShown = false
    
    
    var body: some View {
        VStack{
            if isSettingsShown == false {Map(
                coordinateRegion: $region,
                annotationItems: [user]){ user in
                    MapAnnotation(coordinate: user.coordinates, anchorPoint: CGPoint(x: 0.5, y: 0.5)){
                        AsyncImage(url: URL(string: user.picture.large)){ Image in
                            Image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(radius: 5)
                                .onTapGesture {
                                    isSettingsShown.toggle()
                                }
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }
            }
                .frame(width: 350.0, height: 350.0)
                .clipShape(Circle())
                .shadow(radius: 5)}
            else {AsyncImage(url: URL(string: user.picture.large)){ Image in
                Image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .clipShape(Circle())
//                    .overlay(
//                        Circle()
//                            .stroke(Color.white, lineWidth: 2)
//                    )
                    .shadow(radius: 5)
                    .onTapGesture {
                        isSettingsShown.toggle()
                    }
                
            } placeholder: {
                ProgressView()
            }}
            
//            AsyncImage(url: URL(string: user.picture.large)){ Image in
//                Image
//                    .scaledToFill()
//                
//            } placeholder: {
//                ProgressView()
//            }
            HStack(alignment: .center){
                Text(user.name.title)
                Text(user.name.first)
                Text(user.name.last)
            }
            .padding(40)
            .font(.title)
            Spacer()
            
        }
//        .navigationBarItems(leading:
//                            Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//                            }) {
//                                Image(systemName: "globe")
//                            }
//                        )
//        .navigationBarBackButtonHidden(true)

    }
    
    
}


struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User(
            name: User.Name(title: "hr",first: "test",last: "testsen"),
            location: User.Location(coordinates: User.Location.Coordinates(latitude: "7", longitude: "89")) ,
            picture: User.Picture(large: "",medium: "",thumbnail: "")), region: MKCoordinateRegion() )
        .environmentObject(StateController())
        .environmentObject(LocationController())
    }
}
