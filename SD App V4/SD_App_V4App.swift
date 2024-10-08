//
//  SD_App_V4App.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI
import FirebaseCore
import MinimizableView

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct SD_App_V4App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var navigationState = NavigationState()
    @StateObject private var sessionManager = SessionManager()
    @StateObject private var bluetoothViewModel = BluetoothViewModel()
    @StateObject var timerViewModel = TimerViewModel(countdownTime: 0) // For a 60 seconds countdown

    
    var body: some Scene {
        WindowGroup {
            Group {
                if sessionManager.isLoading {
                    SplashScreen()
                } else if sessionManager.isUserAuthenticated {
                    RootView()
                } else {
                    ContentView()
                }
            }
            .environmentObject(navigationState)
            .environmentObject(sessionManager)
            .environmentObject(bluetoothViewModel)
            .environmentObject(timerViewModel)
        }
    }
}

