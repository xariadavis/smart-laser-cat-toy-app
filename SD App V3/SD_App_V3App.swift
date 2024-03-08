//
//  SD_App_V3App.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/30/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@available(iOS 17.0, *)
@main
struct SD_App_V3App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    @StateObject private var authViewModel = AuthViewModel(authService: FirebaseAuthService(), userService: UserManager())
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isAuthenticated {
                    ContentView()
                } else {
                    WelcomeView()
                        // .environmentObject(AuthViewModel(authService: FirebaseAuthService()))
                }
    
            }
            .environmentObject(authViewModel)
            .environmentObject(userViewModel)
        }
    }
}
