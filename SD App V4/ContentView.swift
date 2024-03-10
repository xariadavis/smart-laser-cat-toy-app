//
//  ContentView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationState: NavigationState

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            WelcomeView()
                .navigationDestination(for: AuthenticationNavigation.self) { target in
                    switch target {
                    case .login:
                        LoginView()
                            .navigationBarBackButtonHidden(true)
                    case .register:
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    case .forgotPassword:
                        ForgotPasswordView()
                    case .dashboard:
                        DashboardView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
                .navigationDestination(for: MainNavigation.self) { target in
                    switch target {
                    case .dashboard:
                        DashboardView()
                            .navigationBarBackButtonHidden(true)
                    case .patternsList:
                        PatternsView()
                            .navigationBarBackButtonHidden(true)
                    case .profile:
                        ProfileView()
                            .navigationBarBackButtonHidden(true)
                    case .settings:
                        SettingsView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}
