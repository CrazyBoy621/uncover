//
//  uncoverApp.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/05/23.
//

import SwiftUI
import IQKeyboardManagerSwift
import Firebase
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        
        // Increase app open count
        var appOpenCount = UserDefaults.standard.integer(forKey: "AppOpenCount")
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: "AppOpenCount")
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct uncoverApp: App {
    @AppStorage("onboarding") var onboarding: Bool = true
    @AppStorage("login") var login: Bool = true
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var networkManager = NetworkManager()
    @State var isAvailable = true
    @State var showSplash = true
    
    init() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        ServiceAPI.shared.getInitialData { response, error in
            if let response = response {
//                print(response.isBeAvailable)
//                isAvailable = response.isBeAvailable ?? false
            }
        }
        
//        ServiceAPI.shared.getBooksList(languageCode: "en", search: "example") { response, error in
//            if let response = response {
//                print("RESPONSE: ", response)
//            }
//        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                ZStack {
                    if isAvailable {
                        if onboarding {
                            NavigationView {
                                OnboardingView()
                            }
                        } else if login {
                            NavigationView {
                                WelcomeView()
                            }
                        } else {
                            ContentView()
                        }
                    } else {
                        UnderConstructionView()
                    }
                    
                    if !networkManager.isOnline {
                        NoInternetView()
                            .transition(.move(edge: .top))
                    }
                    
                    if showSplash {
                        SplashScreen()
                            .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showSplash = false
                            }
                        }
                    }
                }
            }
        }
    }
}
