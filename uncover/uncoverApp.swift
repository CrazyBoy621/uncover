//
//  uncoverApp.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/05/23.
//

import SwiftUI
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    
    @AppStorage("isPremiumUser") var isPremiumUser: Bool = false
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct uncoverApp: App {
    
    @AppStorage("onboarding") var onboarding: Bool = true
    @AppStorage("login") var login: Bool = true
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
