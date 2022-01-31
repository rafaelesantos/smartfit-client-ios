//
//  MapView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 30/01/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    // MARK: - PROPERTIES
    
    @State private var region: MKCoordinateRegion = {
        let currentLocation = try? DataManager.shared.get(on: .currentLocation, MapLocation.self)
        var mapCoordinates = CLLocationCoordinate2D(latitude: currentLocation?.latitude ?? 0, longitude: currentLocation?.longitude ?? 0)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    var locations: [MapLocation]
    @State var name: String = ""
    @State var hour: String = ""
    @State var count: String = ""
    
    // MARK: - BODY
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations, annotationContent: { item in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
                MapAnnotationView(hour: item.hour, locationName: item.name)
                    .onTapGesture {
                        self.name = item.name
                        self.hour = item.hour
                        self.count = "\(item.count)"
                    }
            }
        })
            .overlay(
                self.name.isEmpty == false ?
                VStack {
                    HStack(alignment: .center, spacing: 12) {
                        Image("compass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                Spacer()
                                Text("Último Acesso")
                                    .font(.system(size: 15))
                                Text("\(hour)")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(.accentColor)
                            }
                            
                            Divider()
                            
                            HStack {
                                Spacer()
                                Text("\(name)")
                                    .font(.system(size: 15))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(
                        Color.black
                            .cornerRadius(8)
                            .opacity(0.6)
                    )
                    .padding()
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 5) {
                        Text("\(count)")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Text("ACESSOS")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    .padding(.all, 10)
                    .background(
                        Color.black
                            .cornerRadius(8)
                            .opacity(0.6)
                    )
                }.padding(.bottom, 12) : nil
                , alignment: .top
            )
    }
}
