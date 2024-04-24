//
//  LoginAndRegistrationView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/23/24.
//

import SwiftUI

struct LoginAndRegistrationView: View {
    @State private var userStatus: UserStatus = .notRegistered
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Login", destination: LoginView(userStatus: $userStatus))
                NavigationLink("Register", destination: RegistrationView(userStatus: $userStatus))
            }
        }
    }
}

#Preview {
    LoginAndRegistrationView()
}
