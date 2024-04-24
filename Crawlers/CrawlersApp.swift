//
//  CrawlersApp.swift
//  Crawlers
//
//  Created by Cody Burgess on 3/26/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

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

    func listen() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.isLoggedIn = true
            } else {
                self.isLoggedIn = false
            }
        }
    }

    init() {
        listen()
    }

    func logout() {
        try? Auth.auth().signOut()
        self.isLoggedIn = false
    }
}

