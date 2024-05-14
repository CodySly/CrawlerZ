//
//  accountView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/1/24.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    @State private var image: UIImage?
    @State private var isImagePickerPresented = false
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isEmailValid: Bool = true

    var body: some View {
        NavigationView {
            VStack {
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                }
                Button("Change Photo") {
                    isImagePickerPresented = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $image)
                }
                .onChange(of: image) { newImage in
                    uploadAndUpdateImage(newImage)
                }
                
                //Spacer between photo button and text field
                Spacer()

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

                Spacer()

                Button("Update Account") {
                    updateAccount()
                }
                .padding()
                .background(isEmailValid ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(!isEmailValid)

                Spacer()
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        session.logout()
                    }
                }
            }
            .onAppear {
                loadUserData()
            }
        }
    }

    private func loadUserData() {
        if let user = Auth.auth().currentUser {
            email = user.email ?? ""
            username = user.displayName ?? ""
        }
    }

    private func updateAccount() {
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Error updating user profile: \(error.localizedDescription)")
                }
            }

            // Update email with verification
            user.sendEmailVerification(beforeUpdatingEmail: email) { error in
                if let error = error {
                    print("Error sending email verification: \(error.localizedDescription)")
                } else {
                    print("Verification email sent. Please verify to update your email address.")
                }
            }
        }
    }
    
    private func uploadAndUpdateImage(_ newImage: UIImage?) {
        guard let newImage = newImage else { return }
        ImageManager.shared.uploadImage(image: newImage) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let url):
                    ImageManager.shared.saveProfileImageURL(url) { success in
                        if success {
                            print("Image URL saved successfully")
                            // Optionally, update the local state if needed
                        } else {
                            print("Failed to save image URL")
                        }
                    }
                case .failure(let error):
                    print("Error uploading image: \(error)")
                }
            }
        }
    }

    private func loadProfileImage() {
        ImageManager.shared.fetchProfileImageUrl { url in
            if let url = url {
                downloadImage(from: url)
            }
        }
    }

    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

// Preview Provider
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(SessionStore())
    }
}
