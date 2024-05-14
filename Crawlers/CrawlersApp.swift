//
//  CrawlersApp.swift
//  Crawlers
//
//  Created by Cody Burgess on 3/26/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Combine

enum UserStatus {
    case loggedIn
    case loggedOut
    case notRegistered
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CrawlersApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var session = SessionStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}

class SessionStore: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userEmail: String = ""
    @Published var userName: String = ""

    func listen() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if let user = user {
                self?.isLoggedIn = true
                self?.userEmail = user.email ?? ""
                // Assuming the display name is being used as the username
                self?.userName = user.displayName ?? "Anonymous"
            } else {
                self?.isLoggedIn = false
                self?.userEmail = ""
                self?.userName = ""
            }
        }
    }

    init() {
        listen()
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
        self.isLoggedIn = false
        self.userEmail = ""
        self.userName = ""
    }
}

