//
//  uncoverApp.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/05/23.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct uncoverApp: App {
    
    @AppStorage("onboarding") var onboarding: Bool = true
    @AppStorage("login") var login: Bool = true
    
    init() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    var body: some Scene {
        WindowGroup {
            if onboarding {
                NavigationView {
                    OnboardingView()
                }
            }
            else if login {
                NavigationView {
                    WelcomeView()
                }
            }
            else{
                ContentView()
            }
        }
    }
}
