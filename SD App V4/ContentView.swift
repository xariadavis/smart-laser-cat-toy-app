//
//  ContentView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        
        NavigationStack(path: $navigationState.path) {
            
            WelcomeView()
                .navigationDestination(for: AuthenticationNavigation.self) { target in
                    switch target {
                    case .login:
                        LoginView(viewModel: LoginViewModel(authViewModel: AuthViewModel()))
                            .navigationBarBackButtonHidden(true)
                    case .register:
                        SignUpView(viewModel: SignUpViewModel(authViewModel: AuthViewModel(), firestoreManager: FirestoreManager()))
                            .navigationBarBackButtonHidden(true)
                    case .forgotPassword:
                        ForgotPasswordView()
                    case .onboarding(let catName):
                        let authViewModel = AuthViewModel()
                        OnboardingView(catName: catName, authViewModel: authViewModel)
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
                        ProfileView(viewModel: ProfileViewModel(firestoreManager: FirestoreManager()))
                            .navigationBarBackButtonHidden(true)
                    case .settings:
                        SettingsView(viewModel: SettingsViewModel(authViewModel: AuthViewModel()))
                            .navigationBarBackButtonHidden(true)
                    case .root:
                        RootView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
                .navigationDestination(for: LoadingNavigation.self) { target in
                    switch target {
                    case .loadingFromOnboarding(let userID):
                        LoadingRegistrationView(userID: userID)
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}
