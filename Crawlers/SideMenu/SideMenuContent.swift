//
//  SideMenuContent.swift
//  King Crawlers
//
//  Created by Cody Burgess on 10/17/23.
//

import SwiftUI

struct SideMenuContent: View {
    @Binding var presentSideMenu: Bool
    @StateObject private var vm = TrailLocationViewModel()
    
    var body: some View {
            ZStack {
                Color(Color(.systemGray))
                  .ignoresSafeArea()
                VStack {
                    Image("KingLogo1024")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding(.top, 25)
                    
                    VStack {
                        HStack {
                            Text("Menu")
                                .foregroundColor(.black)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding(.bottom, 25)
                    }
                    
                    VStack(spacing: 50) {
                        NavigationLink(
                            destination: LocationView()
                                .environmentObject(vm),
                            label: {
                        HStack(spacing: 15) {

                                Image(systemName: "mountain.2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                
                                Text("Trails")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .frame(alignment: .leading)
                            }
                        })
                        NavigationLink(
                                destination: TreadView(),
                                label: {
                        HStack(spacing: 15) {
                                Image(systemName: "signpost.right.and.left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.indigo)
                                
                                Text("Treads")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .frame(alignment: .leading)
                            }
                        })
                        NavigationLink(
                                destination: SocialGridView(),
                                label: {
                        HStack(spacing: 15) {
                                Image(systemName: "person.bubble.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.indigo)
                                
                                Text("Social Media")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .frame(alignment: .leading)
                            }
                        })
                        Spacer(minLength: 25)
                    }
                }
            }
    }
    @ViewBuilder
    private func SideMenuTopView() -> some View {
    }
}


