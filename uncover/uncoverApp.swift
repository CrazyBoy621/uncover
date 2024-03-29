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
        
#if DEBUG
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-debug", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseApp.configure(options: options!)
#else
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-QA", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseApp.configure(options: options!)
#endif
        
        // Increase app open count
        var appOpenCount = UserDefaults.standard.integer(forKey: "AppOpenCount")
        appOpenCount += 1
        print("App Open Count: ", appOpenCount)
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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var networkManager = NetworkManager()
    @State var isAvailable = true
    @State var showSplash = true
    let userIDToken = UserDefaults.standard.string(forKey: "userIDToken")
    
    init() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        ServiceAPI.shared.getInitialData { response, error in
            if let response = response {
                print("RESPONSE: ", response)
                //                isAvailable = response.isBeAvailable ?? false
            } else {
                print("ERROR: ", error ?? "Error")
            }
        }
        
        ServiceAPI.shared.getHomeModules { response, error in
            if let response = response {
                print("Home Module: ", response)
            } else {
                print("Home Module Error: ", error ?? "Error")
            }
        }
        
        ServiceAPI.shared.postHomeModules { response, error in
            if let response = response {
                print("Home Module: ", response)
            } else {
                print("Home Module Error: ", error ?? "Error")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                ZStack {
                    if userIDToken == nil {
                        NavigationView {
                            WelcomeView()
                        }
                    } else {
                        if isAvailable {
                            if onboarding {
                                NavigationView {
                                    OnboardingView()
                                }
                            } else {
                                ContentView()
                            }
                        } else {
                            UnderConstructionView()
                        }
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
