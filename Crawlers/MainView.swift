//
//  MainView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/23/24.
//

import SwiftUI

struct MainView: View {
    @State private var presentSideMenu = false
    @State private var presentAccountView = false
    @State private var presentMapView = false
    @State private var presentLoginView = false
    @State private var isLoggedIn = false
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray).edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("KingCrawlersLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 125)
                        .padding(.top, 20)
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8, content: {
                            Text("Follow our Social Media")
                            +
                            Text(" for Updates and Event Annocuments")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            NavigationLink(destination: SocialGridView(), label: {
                                Text("Follow Now")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.vertical,10)
                                    .background(Color(.red))
                                    .clipShape(Capsule())
                            })
                        })
                        .padding(.leading)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "person.bubble.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .padding(.trailing)
                        
                    }
                    .padding()
                    .background(Color(.orange))
                    .cornerRadius(25)
                    .padding(.horizontal)
                    
                    
                    
                    
                    ScrollView {
                        Image("Pinnacle1")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    
                    //Bottom of Page
                    
                    HStack{
                        VStack{
                            Text("Developed By")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Image("PixelLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75)
                                .padding(5)
                        }
                    }
                }
                
                
                if presentSideMenu {
                    SideMenuContent(presentSideMenu: $presentSideMenu)
                        .transition(.move(edge: .leading))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            presentSideMenu.toggle()
                        }
                    }) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(15)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        presentMapView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(.red)
                            
                            Text("Utah, USA")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentAccountView.toggle()
                    }) {
                        Image(systemName: "person")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(15)
                    }
                }
            }
            
            .fullScreenCover(isPresented: $presentAccountView) {
                // Present the account view here
                AccountView()
            }
            .fullScreenCover(isPresented: $presentMapView) {
                // Present the map or location view here
                MapView()
            }
        }
    }
}

#Preview {
    MainView()
}
