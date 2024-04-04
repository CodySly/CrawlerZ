//
//  LocationsListView.swift
//  King Crawlers
//
//  Created by Cody Burgess on 10/18/23.
//

import SwiftUI

struct LocationsListView: View {
   
    @EnvironmentObject private var vm: TrailLocationViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)

            }
        }
        .listStyle(PlainListStyle())
        .frame(width: 285)
        .shadow(color: Color.black.opacity(0.3),
                radius: 20)
    }
}

struct LocatonsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(TrailLocationViewModel())
    }
}


extension LocationsListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName + ", " + location.stateName)
                    .font(.subheadline)
            }
            .frame(maxWidth: 300, alignment: .leading)
        }
    }
    
}
