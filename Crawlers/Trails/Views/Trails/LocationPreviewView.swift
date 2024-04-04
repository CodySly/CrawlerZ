//
//  LocationPreviewView.swift
//  King Crawlers
//
//  Created by Cody Burgess on 10/19/23.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: TrailLocationViewModel
    
    
    let location: Location
    
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment:.leading, spacing: 16) {
                
                imageSection
                    .padding(.horizontal)
                
                titleSection
                    .padding(.horizontal)
        
            }
            
            VStack(spacing: 8) {

                learnMoreButton
                   .padding(.horizontal)
                
                nextButton
                   .padding(.horizontal)

            }
        }
        .frame(width: 285, height: 165)
        .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(.ultraThinMaterial)
            .offset(y: 65)
        )
        .cornerRadius(25)
    }

}
//Preview

// struct with static varible to get a preview to work with LocationDataService & Location

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(TrailLocationViewModel())
    }
}

//Extentions

//Created Private Varible to clean up the main body of code


extension LocationPreviewView {

    
    // imageSection
    
    private var imageSection: some View {
        ZStack{
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            }
        }
        .padding(5)
        .background(Color.red)
        .cornerRadius(10)
    }
    
    // titleSection
    
    private var titleSection: some View {
    VStack(alignment: .leading,spacing: 4) {
        Text(location.name)
            .font(.title3)
            .fontWeight(.bold)
        
        
        Text(location.cityName + ", " + location.stateName)
            .font(.footnote)
            .fontWeight(.semibold)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
}
    
    // learnMoreButton
    
    private var learnMoreButton: some View {
        Button {
           vm.sheetLocation = location
        }  label: {
            Text("Learn more")
                .font(.footnote)
                .fontWeight(.bold)
                .frame(width: 75, height: 15)
                .background(Color.red)
        }
        .buttonStyle(.borderedProminent)
    }
    
    // nextButton
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        }  label: {
            Text("Next")
                .font(.footnote)
                .fontWeight(.bold)
                .frame(width: 75, height: 15)
                .background(Color.green)
        }
        .buttonStyle(.bordered)
    }
}


