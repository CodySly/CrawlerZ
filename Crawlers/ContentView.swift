//
//  ContentView.swift
//  Crawlers
//
//  Created by Cody Burgess on 3/26/24.
//

import SwiftUI

    struct ContentView: View {
        @EnvironmentObject var session: SessionStore
        
        var body: some View {
            if session.isLoggedIn {
                MainView()  // Your main app view for logged-in users
            } else {
                LoginAndRegistrationView()  // A view that handles both login and registration
            }
        }
    }
    



