//
//  MapView.swift
//  MobileLab2
//
//  Created by Даниил Крымлов on 12.11.2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    let locationManager = CLLocationManager()
        
        @State var region = MKCoordinateRegion(
            center: .init(latitude: 37.334_900,longitude: -122.009_020),
            span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        
        var body: some View {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    locationManager.requestWhenInUseAuthorization()
                }
        }
}

#Preview {
    MapView()
}
