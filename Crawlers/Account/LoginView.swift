//
//  LoginView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/4/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var errorMessage: String?
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
            ZStack {
                Image("Gordon-Creek-Falls")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
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
                    NavigationLink("Register", destination: RegistrationView(userStatus: $userStatus))
                        .padding()
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .padding()
                .navigationTitle("Login")
                .frame(width: 360)
            }
        }
    }
    
    // Validates the email format
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func loginUser() {
        // Check for valid email and non-empty password
        guard isEmailValid, !password.isEmpty else {
            errorMessage = "Invalid email format or empty password"
            print("Failed attempt: Invalid email format or empty password")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Log and handle errors
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                print("Login error: \(error.localizedDescription)")
                return
            }

            if authResult?.user != nil {
                DispatchQueue.main.async {
                    // Update user status on the main thread
                    self.userStatus = .loggedIn
                }
            }
        }
    }
}

// Preview Provider
struct LoginView_Previews: PreviewProvider {
    @State static var previewUserStatus = UserStatus.loggedOut // Create a mutable state for preview
    
    static var previews: some View {
        LoginView(userStatus: $previewUserStatus)
    }
}

