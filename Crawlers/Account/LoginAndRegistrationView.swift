//
//  LoginAndRegistrationView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/23/24.
//

import SwiftUI

struct LoginAndRegistrationView: View {
    @ObservedObject var messageViewModel: MessageViewModel
    @State private var userStatus: UserStatus = .notRegistered

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Login", destination: LoginView(messageViewModel: messageViewModel, userStatus: $userStatus))
                NavigationLink("Register", destination: RegistrationView(messageViewModel: messageViewModel, userStatus: $userStatus))
            }
        }
    }
}


struct LoginAndRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAndRegistrationView(messageViewModel: MessageViewModel())
    }
}

