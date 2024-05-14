//
//  MessageDataModel.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/24/24.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var content: String
    var timestamp: Timestamp?
    var email: String  // Email of the user who sent the message
    var username: String  // Username of the user who sent the message

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case timestamp
        case email
        case username
    }
}

