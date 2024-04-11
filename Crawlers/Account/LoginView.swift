//
//  LoginView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/4/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = "" {
        didSet {
            isEmailValid = validateEmail(email: email)
        }
    }
    @State private var password = ""
    @State private var isEmailValid: Bool = true
    @Binding var userStatus: UserStatus
    
    var body: some View {
        NavigationView {
            VStack {
                Text("")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.uturn.backward")
                            }
                        }
                    }
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if !isEmailValid {
                    Text("Invalid email format")
                        .foregroundColor(.red)
                }

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    loginUser()
                }) {
                    Text("Login")
                        .padding()
                        .background(isEmailValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .disabled(!isEmailValid)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .background(.gray)
        }
    }
    
    // Validates the email format
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    // Simulates the login process, including validation and feedback
    func loginUser() {
        // Here, insert actual login logic, potentially involving a backend.
        // This placeholder will update the user status upon successful login.
        print("Logging in with Email: \(email), Password: \(password)")
        // Example: Update the userStatus to .loggedIn upon successful login
        self.userStatus = .loggedIn
    }
}

// Preview Provider
struct LoginView_Previews: PreviewProvider {
    @State static var previewUserStatus = UserStatus.loggedOut // Create a mutable state for preview
    
    static var previews: some View {
        LoginView(userStatus: $previewUserStatus)
    }
}

