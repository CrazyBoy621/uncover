//
//  WelcomeView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 20/05/23.
//

import SwiftUI
import Firebase
import GoogleSignIn
import CryptoKit
import AuthenticationServices

class WelcomeViewModel: NSObject, ObservableObject {
    
    var currentNonce: String?
    
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        // Start the sign in flow!
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
    
    func appleLogin() {
        let nonce = randomNonceString(length: 32)
        currentNonce = nonce
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    private func signInWithCredential(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Firebase Sign In Error: \(error.localizedDescription)")
                return
            }
            
            if let accessToken = authResult?.user.uid {
                print("Firebase Access Token: \(accessToken)")
                
                // Use the access token as needed
            }
        }
    }
    
    private func randomNonceString(length: Int) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension WelcomeViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                print("Invalid state: A login callback was received, but no login request was sent.")
                return
            }
            
            guard let appleIDToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to fetch identity token from Apple ID credential.")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            print("\(idTokenString)")
            signInWithCredential(credential)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign In Error: \(error.localizedDescription)")
    }
}

extension WelcomeViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Unable to retrieve the app window.")
        }
        return window
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
                    Button {
                        viewModel.appleLogin()
                    } label: {
                        ContinueWith(imgName: "apple", continueWith: "Apple")
                    }
                    Button { } label: {
                        ContinueWith(imgName: "facebook", continueWith: "Facebook")
                    }
                    NavigationLink(destination: RegisterationView()) {
                        CustomLargeButton(title: "Continue with e-mail", foreground: .white, background: .mainColor)
                    }
                    Button {
                        login = false
                    } label: {
                        Text("Explore as a guest")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.mainColor.opacity(0.8))
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
