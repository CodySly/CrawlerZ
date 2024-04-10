//
//  SocialGridView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/10/24.
//

import SwiftUI

struct SocialGridView: View {
    // Access your social data here
    let socialData = SocialDataService.socialData
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemOrange).edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(socialData) { item in
                            SocialCardView(socialData: item)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Social Media")
            }
        }
    }
}

// Since your SocialData now contains an array for images,
// make sure your SocialCardView is compatible or adjust as needed.


#Preview {
    SocialGridView()
}

