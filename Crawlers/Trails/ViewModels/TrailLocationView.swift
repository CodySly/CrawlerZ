//
//  TrailLocationView.swift
//  King Crawlers
//
//  Created by Cody Burgess on 10/18/23.
//

import SwiftUI
import MapKit

class TrailLocationViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current Location on the Map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    // Current Region on the Map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Show list of locations
    @Published var showLocationList: Bool = false
    
    //Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates, span: mapSpan)
        }
    }
    
     func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList = !showLocationList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    func nextButtonPressed() {
        
        // Get the current index
        // Two ways of doing the function, using the second cleaner way
        
//        let currentIndex = locations.firstIndex { location in
//            return location == mapLocation
//        
//        }
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation}) else {
            print("Could not find current index in locations array!")
            return
        }
        
        //Check current index is valid
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            
            //Next index is Not Vaild
            //restart from 0
            guard let firstlocation = locations.first else { return }
            showNextLocation(location: firstlocation)
            return
        }
        
        //next index is vaild
        
        let nextlocation = locations[nextIndex]
        showNextLocation(location: nextlocation)
    }
}
