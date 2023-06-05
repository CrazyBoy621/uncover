//
//  WelcomeView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 20/05/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class WelcomeViewModel: ObservableObject {
    
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        // Start the sign in flow!
//        let windowScene = UIWindowScene.windows.first?.rootViewController
        if let windowScene = UIApplication.shared.windows.first?.rootViewController {
            GIDSignIn.sharedInstance.signIn(withPresenting: windowScene) { result, error in
                if let user = result?.user,
                   let idToken = user.idToken?.tokenString {
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                   accessToken: user.accessToken.tokenString)
                    print("Ok: ", idToken)
                    print("WWWWWWWWWWW: ", user.accessToken.tokenString)
                }
                
                // ...
            }
        }
    }
}

struct WelcomeView: View {
    
    @StateObject var viewModel = WelcomeViewModel()
    
    @AppStorage("login") var login: Bool = true
    
    var body: some View {
        ScrollView {
            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical, 32)
            
            VStack(spacing: 20) {
                VStack(spacing: 6) {
                    Text("Welcome")
                        .font(.poppinsSemiBold(size: 28))
                        .foregroundColor(.customBlack)
                    
                    Text("Enjoy sharing the books with others")
                        .foregroundColor(.darkGrey)
                        .font(.poppinsRegular(size: 16))
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    Button {
                        viewModel.googleLogin()
                    } label: {
                        ContinueWith(imgName: "google", continueWith: "Google")
                    }
                    Button { } label: {
                        ContinueWith(imgName: "apple", continueWith: "Apple")
                    }
                    Button { } label: {
                        ContinueWith(imgName: "facebook", continueWith: "Facebook")
                    }
                    NavigationLink(destination: RegisterationView()) {
                        CustomLargeButton(title: "Continue with e-mail", foreground: .white, background: .accentColor)
                    }
                    Button {
                        login = false
                    } label: {
                        Text("Explore as a guest")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.accentColor.opacity(0.8))
                    }
                }
                
                Text("Continuing to use Moodreaders means you accept our Terms of Service and Privacy Policy.")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 12, weight: .semibold))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("uncover-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
    }
}
