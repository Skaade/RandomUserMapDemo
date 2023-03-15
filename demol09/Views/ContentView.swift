//
//  ContentView.swift
//  demol09
//
//  Created by dmu mac 25 on 01/03/2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var stateController: StateController
    
    @EnvironmentObject var locationController: LocationController
    
    @State var isSettingsShown = false
    //    private var users: [User] {
    //        stateController.users.sorted(by: $0.name.last < $1.name.last)
    //    }
    
    var body: some View {
        NavigationView{
            VStack{
                locationController.locationManager?.authorizationStatus == .denied ?
                Map(
                    mapRect: $stateController.mapRect, //showsUserLocation: false,
                         annotationItems: stateController.users){ user in
                        MapAnnotation(coordinate: user.coordinates, anchorPoint:  CGPoint(x: 0.5, y: 0.5)){
                            NavigationLink(destination: UserDetailView(user: user, region: MKCoordinateRegion(center: user.coordinates, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))){
                                AsyncImage(url: URL(string: user.picture.large)){ Image in
                                    
                                    Image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                        .shadow(radius: 5)
                                    
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            
                            
                        }
                        
                    }
                         .task {
                             stateController.fit()
                         }
                         .frame(width: 350.0, height: 350.0)
                         .clipShape(Circle())
                         .shadow(radius: 5)
                :
                Map(                    coordinateRegion: $locationController.coordinateRegion, //showsUserLocation: true,

                         annotationItems: stateController.users){ user in
                        MapAnnotation(coordinate: user.coordinates, anchorPoint:  CGPoint(x: 0.5, y: 0.5)){
                            NavigationLink(destination: UserDetailView(user: user, region: MKCoordinateRegion(center: user.coordinates, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))){
                                AsyncImage(url: URL(string: user.picture.large)){ Image in
                                    
                                    Image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                        .shadow(radius: 5)
                                    
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            
                            
                        }
                        
                    }
                         .task {
                             stateController.fit()
                         }
                         .frame(width: 350.0, height: 350.0)
                         .clipShape(Circle())
                         .shadow(radius: 5)
                
                
                List(stateController.users){ user in
                    NavigationLink{
                        UserDetailView(user: user, region: MKCoordinateRegion(center: user.coordinates, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
                    } label: {
                        HStack{
                            AsyncImage(url: URL(string: user.picture.thumbnail)){ Image in
                                Image
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(radius: 5)
                                
                            } placeholder: {
                                ProgressView()
                            }
                            Text("\(user.name.first) \(user.name.last)")
                        }
                    }

                }

                
            }
            .sheet(isPresented: $isSettingsShown) {
                SettingsView(showLocation: true)
            }
            .toolbar{
                ToolbarItem{
                    Button{
                        isSettingsShown = true
                    }label: {
                        Image(systemName: "gearshape")
                    }
                    .foregroundColor(.gray)
                    .font(.title)
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(StateController())
            .environmentObject(LocationController())
    }
}
