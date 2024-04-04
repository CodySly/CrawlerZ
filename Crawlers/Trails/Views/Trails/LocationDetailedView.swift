//
//  LocationDetailedView.swift
//  King Crawlers
//
//  Created by Cody Burgess on 11/6/23.
//

import SwiftUI

struct LocationDetailedView: View {
    
    @EnvironmentObject private var vm: TrailLocationViewModel
    let location: Location
    
    
    var body: some View {
            VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    // String Call
                    
                    Text(location.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(location.cityName + ", " + location.stateName)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Text(location.coordinateNumbers)
                        .font(.footnote)
                        .fontWeight(.thin)
                        .padding(2)
                        .foregroundColor(.red)
                    
                    // Image Call
                    
                    if let imageName = location.imageNames.first {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 200)
                            .padding(-25)
                    }
                    Link ("Trail Demo Video", destination: URL(string: location.link)!)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .tint(.blue)
                    
                    // String Call
                    
                    Text("Rating: " + location.rating)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(2)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 5)
                    
                    Button {
                        
                    } label: {
                        Text("Route Trail")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding()
                            .background(.blue)
                            .clipShape(Capsule())
                        
                    }
                    
                    
                    // Trail Description
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Trial Description:")
                            .font(.footnote)
                            .fontWeight(.thin)
                            .foregroundColor(.orange)
                        
                        Text(location.description)
                            .font(.subheadline)
                            .fontWeight(.light)
                        
                        // Trail Requirements
                        
                        Text("Trail Requirements:")
                            .font(.footnote)
                            .fontWeight(.thin)
                            .foregroundColor(.orange)
                        
                        Text(location.requirement)
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                    .padding(25)
                }

            }
            .padding(.vertical, 25)
            .frame(width: 350, height: 725)
            .background(Color.white.opacity(0.5))
            .cornerRadius(25)
            .shadow(radius: 40)
            .overlay(backButton, alignment: .topLeading)
        }
    }
}

#Preview {
    LocationDetailedView(location: LocationsDataService.locations.first!)
}

extension LocationDetailedView {
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding()
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
                
        }
    }
}
