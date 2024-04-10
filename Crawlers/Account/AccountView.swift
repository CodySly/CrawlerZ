//
//  accountView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/1/24.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Button("HomePage") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        // Update account information
                        // You can add your account update logic here
                        // For simplicity, we'll just print the updated information
                        print("Username: \(username), Email: \(email), Password: \(password)")
                    }) {
                        Text("Update Account")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Button(action: {
                        // Perform logout action
                        // Add your logout logic here
                        print("Logout")
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    Spacer()
                }
                .padding()
                .background(.gray)
                .navigationTitle("Account")
                
            }
        }
    }
}

#Preview {
    AccountView()
}
