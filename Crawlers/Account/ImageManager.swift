//
//  ImageManager.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/23/24.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import UIKit
import FirebaseAuth

class ImageManager {
    static let shared = ImageManager()

    private init() {}

    func uploadImage(image: UIImage?, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.4) else {
            completion(.failure(NSError(domain: "local", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image"])))
            return
        }

        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images/\(uid).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            guard metadata != nil else {
                completion(.failure(error ?? NSError(domain: "Firebase", code: 0, userInfo: [NSLocalizedDescriptionKey: "Firebase upload error"])))
                return
            }

            storageRef.downloadURL { url, error in
                if let url = url {
                    completion(.success(url))
                } else {
                    completion(.failure(error ?? NSError(domain: "Firebase", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL retrieval error"])))
                }
            }
        }
    }

    func saveProfileImageURL(_ url: URL, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(uid).updateData(["profileImageUrl": url.absoluteString]) { error in
            completion(error == nil)
        }
    }

    func fetchProfileImageUrl(completion: @escaping (URL?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists, let urlString = document.get("profileImageUrl") as? String, let url = URL(string: urlString) {
                completion(url)
            } else {
                completion(nil)
            }
        }
    }
}
