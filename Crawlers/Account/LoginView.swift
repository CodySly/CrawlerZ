//
//  LoginView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/4/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @Binding var userStatus: UserStatus
    
    var body: some View {
        NavigationView {
            VStack {
                Button("HomePage") {
                    presentationMode.wrappedValue.dismiss()
                }
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    // Perform login authentication
                    // You can add your authentication logic here
                    // For simplicity, we'll just print the email and password
                    print("Email: \(email), Password: \(password)")
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .background(.gray)
        }
    }
    // Example function to simulate login success
    func loginUser() {
        // Update the userStatus to .loggedIn upon successful login
        self.userStatus = .loggedIn
    }
}

// Preview Provider
struct LoginView_Previews: PreviewProvider {
    @State static var previewUserStatus = UserStatus.loggedOut // Create a mutable state for preview
    
    static var previews: some View {
        // Bind the preview state to the LoginView
        LoginView(userStatus: $previewUserStatus)
    }
}
