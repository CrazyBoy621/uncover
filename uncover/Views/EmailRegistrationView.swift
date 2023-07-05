//
//  EmailRegistrationView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 05/07/23.
//

import SwiftUI
import Firebase

enum RegisterationType {
    case signup
    case signin
}

struct EmailRegistrationView: View {
    
    @State var currentPage: RegisterationType = .signup
    
    @State var email = ""
    @State var password = ""
    @State var username = ""
    
    @State var isUsernameValidated = false
    @State var isPasswordSecure = true
    @State var isEmailCorrect = false
    @State var isPasswordCorrect = false
    
    @State var showEmailAlert = false
    @State var showPasswordAlert = false
    @State var showResetAlert = false
    
    @State var emailAlertText = ""
    @State var passwordAlertText = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                Rectangle()
                    .fill(Color.silver)
                    .frame(height: 60)
                Image("registeration-background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    TopButtons()
                    BottomSide()
                }
                .padding(.horizontal, 24)
                .padding(.top, 260)
            }
        }
        .overlay{
            if showResetAlert {
                ResetAlert()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("uncover-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Te")
                    .foregroundColor(.clear)
            }
        }
    }
    
    @ViewBuilder func TopButtons() -> some View {
        HStack{
            Spacer()
            Button {
                withAnimation {
                    currentPage = .signup
                    isPasswordSecure = true
                }
                password = ""
            } label: {
                Text("sign_up".localized)
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(currentPage == .signin ? Color.lightGrey : Color.mainColor)
            }
            Spacer()
            Button {
                withAnimation {
                    currentPage = .signin
                    isPasswordSecure = true
                }
                password = ""
            } label: {
                Text("login".localized)
                    .font(.poppinsBold(size: 16))
                    .foregroundColor(currentPage == .signup ? Color.lightGrey : Color.mainColor)
            }
            Spacer()
        }
    }
    
    @ViewBuilder func BottomSide() -> some View {
        VStack(spacing: 20) {
            if currentPage == .signup {
                TextField("username".localized, text: $username)
                    .frame(height: 55)
                    .padding(.horizontal, 13)
                    .padding(.trailing, isUsernameValidated ? 27 : 0)
                    .background(Color.containerGrey.cornerRadius(15))
                    .autocapitalization(.none)
                    .overlay(
                        Image(systemName: isUsernameValidated ? "checkmark" : "")
                            .foregroundColor(.checkMarkColor)
                            .padding(.trailing, 14)
                        , alignment: .trailing
                    )
            }
            
            EmailInput()
                .keyboardType(.emailAddress)
            PasswordInput()
            
            Button {
                if showEmailAlert == false && showPasswordAlert == false {
                    if currentPage == .signup {
                            print("Working on it")
                            signUp(email: email, password: password) { response, error in
                                if let response = response {
                                    print("SIGN UP RESPONSE: ", response)
                                }
                            }
                    } else if currentPage == .signin {
                        if !email.isEmpty && !password.isEmpty {
                            signIn(email: email, password: password)
                        }
                    }
                }
            } label: {
                CustomLargeButton(title: currentPage == .signup ? "sign_up".localized : "login".localized, foreground: .white, background: .mainColor)
            }
            .padding(.top, 4)
            
            if currentPage == .signin {
                Button {
                    withAnimation {
                        showResetAlert = true
                    }
                } label: {
                    Text("forgot_password".localized)
                        .foregroundColor(.softBlue)
                }
            }
        }
    }
    
    @ViewBuilder func EmailInput() -> some View {
        VStack {
            TextField("email".localized, text: $email)
                .frame(height: 55)
                .padding(.horizontal, 13)
                .padding(.trailing, currentPage == .signup && isEmailCorrect ? 27 : 0)
                .background(Color.containerGrey.cornerRadius(15))
                .autocapitalization(.none)
                .overlay(
                    Image(systemName: "checkmark")
                        .foregroundColor(currentPage == .signup && isEmailCorrect ? .checkMarkColor : .clear)
                        .padding(.trailing, 14)
                    , alignment: .trailing
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(showEmailAlert ? Color.customRed : Color.clear, lineWidth: 1)
                )
                .onChange(of: email) { newValue in
                    if currentPage == .signup {
                        validateEmail()
                    }
                    
                    if newValue.isEmpty {
                        withAnimation {
                            isEmailCorrect = false
                            showEmailAlert = true
                            emailAlertText = "email_address_required".localized
                        }
                    }
                }
                .onChange(of: isEmailCorrect) { newValue in
                    withAnimation {
                        if newValue {
                            showEmailAlert = false
                        } else {
                            showEmailAlert = true
                        }
                    }
                }
                .onChange(of: currentPage) { newValue in
                    if newValue == .signin {
                        withAnimation {
                            showEmailAlert = false
                        }
                    } else {
                        validateEmail()
                    }
                }
            
            if showEmailAlert {
                Text(emailAlertText)
                    .font(.poppinsRegular(size: 12))
                    .foregroundColor(.customRed)
                    .padding(.horizontal, 13)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    @ViewBuilder func PasswordInput() -> some View {
        VStack {
            ZStack {
                if isPasswordSecure {
                    SecureField("password".localized, text: $password)
                } else {
                    TextField("password".localized, text: $password)
                }
            }
            .frame(height: 55)
            .padding(.horizontal, 13)
            .padding(.trailing, 27)
            .background(Color.containerGrey.cornerRadius(15))
            .overlay(
                Button{
                    isPasswordSecure.toggle()
                } label: {
                    Image(isPasswordSecure ? "eye-close" : "eye-open")
                        .foregroundColor(.checkMarkColor)
                        .padding(.trailing, 14)
                }
                , alignment: .trailing
            )
            
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(showPasswordAlert ? Color.customRed : Color.clear, lineWidth: 1)
            )
            .autocapitalization(.none)
            .onChange(of: password) { newValue in
                withAnimation {
                    if password.isEmpty {
                        showPasswordAlert = true
                        passwordAlertText = "password_is_required".localized
                    } else {
                        showPasswordAlert = false
                    }
                }
            }
            
            if showPasswordAlert {
                Text(passwordAlertText)
                    .font(.poppinsRegular(size: 12))
                    .foregroundColor(.customRed)
                    .padding(.horizontal, 13)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    @ViewBuilder func ResetAlert() -> some View {
        ZStack {
            Color.black.opacity(0.3)
            
            VStack(spacing: 24) {
                VStack (spacing: 16) {
                    Text("reset_password".localized)
                        .font(.poppinsBold(size: 22))
                        .foregroundColor(.customBlack)
                    
                    Text("reset_password_alert".localized)
                        .multilineTextAlignment(.center)
                        .font(.poppinsMedium(size: 18))
                        .foregroundColor(.darkGrey)
                }
                
                HStack(spacing: 20) {
                    Button {
                        withAnimation {
                            showResetAlert = false
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.mainColor, lineWidth: 1)
                            .frame(width: 91, height: 35)
                            .overlay(
                                Text("cancel".localized)
                                    .foregroundColor(.mainColor)
                                    .font(.poppinsMedium(size: 16))
                            )
                    }
                    
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.mainColor)
                            .frame(width: 91, height: 35)
                            .overlay(
                                Text("yes".localized)
                                    .foregroundColor(.white)
                                    .font(.poppinsMedium(size: 16))
                            )
                    }
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 40)
            .background(Color.white.cornerRadius(20))
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func signUp(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign-up error: \(error.localizedDescription)")
            } else {
                guard let user = authResult?.user else {
                    print("User not found after sign-up")
                    return
                }
                
                // Retrieve the user's authentication tokens
                user.getIDToken { token, error in
                    if let error = error {
                        print("Error retrieving user ID token: \(error.localizedDescription)")
                    } else if let token = token {
                        let userIDToken = token // User ID token
                        print("User ID token: \(userIDToken)")
                        UserDefaults.standard.set(userIDToken, forKey: "userIDToken")
                        
                    }
                }
                
                print("Sign-up successful")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Handle error
                print("Error logging in: \(error)")
            } else {
                // Successfully logged in.
                
                // Step 3: Disregarding authResult.
                
                // Step 4: Setup interceptor for backend calls.
                
                // a: Get the instance of Firebase SDK
                let auth = Auth.auth()
                
                // b: Retrieve current user
                if let currentUser = auth.currentUser {
                    
                    // c: Get user token
                    currentUser.getIDTokenForcingRefresh(false) { idToken, error in
                        if let error = error {
                            // Handle error
                            print("Error getting ID Token: \(error)")
                        } else {
                            // You have your idToken here. Use it as you need to.
                            let firebaseToken = idToken ?? ""
                            print("Token: ", idToken)
                            UserDefaults.standard.set(idToken, forKey: "userIDToken")
                            
                            // d: Add token as header to your backend call. This is pseudo code, adjust to your actual backend call.
                            var request = URLRequest(url: URL(string: "https://yourbackend.com/endpoint")!)
                            request.addValue("FirebaseToken \(firebaseToken)", forHTTPHeaderField: "Authorization")
                            
                            // Send the request ...
                            
                            // e: Store firebase user id
                            let firebaseUid = currentUser.uid
                            // Store firebaseUid as per your requirement
                        }
                    }
                }
            }
        }
    }
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if emailPredicate.evaluate(with: email) {
            ServiceAPI.shared.checkEmailAvailability(email: email) { response, error in
                if let response = response {
                    isEmailCorrect = response
                } else {
                    isEmailCorrect = false
                    emailAlertText = "provide_correct_email_address".localized
                }
            }
        } else {
            isEmailCorrect = false
            emailAlertText = "provide_correct_email_address".localized
        }
        
        withAnimation {
            if isEmailCorrect {
                showEmailAlert = false
            } else {
                showEmailAlert = true
            }
        }
    }
}

struct EmailRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmailRegistrationView()
        }
    }
}
