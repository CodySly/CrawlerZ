//
//  Location.swift
//  King Crawlers
//
//  Created by Cody Burgess on 10/18/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    let name: String
    let cityName: String
    let stateName: String
    let coordinates: CLLocationCoordinate2D
    let coordinateNumbers: String
    let rating: String
    let description: String
    let requirement: String
    let imageNames: [String]
    let link: String
    
    var id: String {
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

}
