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
    // Example state variable to track user status
    @State private var userStatus = UserStatus.notRegistered
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Use a switch statement to handle different views based on user status
//            switch userStatus {
//            case .loggedIn:
//                ContentView()
//            case .loggedOut:
//                LoginView(userStatus: $userStatus)
//            case .notRegistered:
//                RegistrationView() // Assuming you have a view for registration
//            }
        }
    }
}


