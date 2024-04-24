//
//  RegistrationView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/4/24.
//

import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var userStatus: UserStatus  // Added binding to userStatus
    @State private var email: String = "" {
        didSet {
            isEmailValid = validateEmail(email: email)
        }
    }
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isEmailValid: Bool = true
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Upper-Diff-Hanger")
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
                    
                    SecureField("Confirm Password", text: $confirmPassword) // Add this SecureField
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if password != confirmPassword && !confirmPassword.isEmpty {
                        Text("Passwords do not match")
                            .foregroundColor(.red)
                    }
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button("Register") {
                        // Ensuring email is valid before proceeding
                        guard isEmailValid else { return }
                        registerUser(email: email, password: password)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(isEmailValid ? Color.blue : Color.gray)
                    .cornerRadius(8)
                    .disabled(!isEmailValid)
                }
                .padding()
                .navigationTitle("User Registration")
                .frame(width: 360)
            }
        }
    }
    
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                // Implement registration logic here, potentially involving asynchronous operations
                // Placeholder for registration logic
                print("Attempting to register user with email: \(email) and password: \(password)")
            } else if authResult?.user != nil {
                DispatchQueue.main.async {
                    self.userStatus = .loggedIn // or .loggedOut if they need to log in after registering
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
// Preview provider
struct RegistrationView_Previews: PreviewProvider {
    @State static var previewUserStatus = UserStatus.notRegistered  // Create a mutable state for preview
    static var previews: some View {
        RegistrationView(userStatus: $previewUserStatus)
    }
}

    
