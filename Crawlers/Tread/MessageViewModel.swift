//
//  MessageViewModel.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/24/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift  // Ensure you import FirebaseFirestoreSwift for Codable support
import Combine  // Import Combine for ObservableObject

class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageContent: String = ""  // Declare the property for message input
    @Published var userEmail: String = ""  // Email of the user
    @Published var userName: String = ""  // Username of the user

    private var db = Firestore.firestore()
    private var sessionStore = SessionStore()

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadData()
        observeAuthenticationChanges()
    }
    
    func loadData() {
        db.collection("messages").order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self?.messages = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Message.self)
                    }
                } else if let error = error {
                    print("Error getting messages: \(error.localizedDescription)")
                }
            }
    }

    func postMessage() {
        guard !newMessageContent.isEmpty else { return }
        let newMessage = Message(content: newMessageContent, timestamp: Timestamp(date: Date()), email: sessionStore.userEmail, username: sessionStore.userName)
        do {
            _ = try db.collection("messages").addDocument(from: newMessage)
            newMessageContent = ""
        } catch let error {
            print("Error writing message to Firestore: \(error.localizedDescription)")
        }
    }

    private func observeAuthenticationChanges() {
        sessionStore.$userEmail
            .assign(to: \.userEmail, on: self)
            .store(in: &cancellables)

        sessionStore.$userName
            .assign(to: \.userName, on: self)
            .store(in: &cancellables)
    }
}

