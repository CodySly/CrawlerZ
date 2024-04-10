//
//  SocialCardView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/10/24.
//
import SwiftUI

struct SocialCardView: View {
    var socialData: SocialData
    
    var body: some View {
        VStack {
            // Try to load the first image from imageSocial, or use a default placeholder
            if let imageName = socialData.imageSocial.first {
                Image(imageName) // Assumes images are stored in Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.top)
            } else {
                Image(systemName: "person.bubble.fill") // Fallback placeholder image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.top)
            }
            
            Text(socialData.nameSocial)
                .fontWeight(.medium)
                .foregroundColor(.black) // Set a text color that contrasts with the background
            
            Link(destination: URL(string: socialData.urlSocial)!) {
                Text("Follow")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .frame(width: 150, height: 200)
        .background(Color.white) // Ensure card background contrasts with text
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}



// Define the PreviewProvider
struct SocialCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide an example SocialData instance here
        SocialCardView(socialData: SocialData(nameSocial: "Example Social Media", urlSocial: "https://www.example.com", imageSocial: ["String"]))
    }
}

