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
                        LoginView(viewModel: LoginViewModel(authViewModel: AuthViewModel()))
                            .navigationBarBackButtonHidden(true)
                    case .register:
                        SignUpView(viewModel: SignUpViewModel(authViewModel: AuthViewModel()))
                            .navigationBarBackButtonHidden(true)
                    case .forgotPassword:
                        ForgotPasswordView()
                    case .root:
                        RootView()
                            .navigationBarBackButtonHidden(true)
                    case .onboarding(let catName):
                        Onboarding(catName: catName)
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
