//
//  MapView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/1/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Button("HomePage") {
            presentationMode.wrappedValue.dismiss()
        }
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
            MapPitchToggle()
        }
        .mapStyle(.imagery(elevation: .automatic))
        
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    MapView()
}
