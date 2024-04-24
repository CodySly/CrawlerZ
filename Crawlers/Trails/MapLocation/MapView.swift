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
        ZStack(alignment: .topLeading) {
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
            //Back Button Code
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.uturn.backward")
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .foregroundColor(.blue)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    MapView()
}
