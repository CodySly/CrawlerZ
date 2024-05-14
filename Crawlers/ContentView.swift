//
//  ContentView.swift
//  Crawlers
//
//  Created by Cody Burgess on 3/26/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    @StateObject var messageViewModel = MessageViewModel()

    var body: some View {
        if session.isLoggedIn {
            MainView(messageViewModel: messageViewModel)
                .onAppear {
                    messageViewModel.userEmail = session.userEmail
                    messageViewModel.userName = session.userName
                }
        } else {
            LoginAndRegistrationView(messageViewModel: messageViewModel)
        }
    }
}



    



