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
    @State private var email = "" {
        didSet {
            isEmailValid = validateEmail(email: email)
        }
    }
    @State private var password = ""
    @State private var isEmailValid: Bool = true
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
//                    Button("HomePage") {
//                        presentationMode.wrappedValue.dismiss()
//                    }
                    Text("Content")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "arrow.uturn.backward")
                                }
                            }
                        }
                    //Account Info UserName, Image, bio, ect
                    VStack {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                            TextField("Username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                    }
                    .background(.red)
                    VStack {
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
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
                        // Ideally, here you'd have logic to update the account,
                        // like sending data to a server after validation checks.
                        print("Username: \(username), Email: \(email), Password: \(password)")
                    }) {
                        Text("Update Account")
                            .padding()
                            .background(isEmailValid ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .disabled(!isEmailValid)
                    }
                    }
                    .background(.blue)
                    
                    Button(action: {
                        // Perform logout action
                        // This might involve clearing user data, tokens, and navigating to a login view.
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
    
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

// Preview Provider for SwiftUI Previews
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
