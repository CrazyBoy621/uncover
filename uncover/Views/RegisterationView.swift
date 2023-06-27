//
//  RegistrationView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI
import Firebase

enum Registeration{
    case signup
    case signin
}

struct RegisterationView: View {
    
    @State var currentPage: Registeration = .signup
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    @State var isUsernameValidated = false
    @State var isEmailValidated = false
    @State var isPasswordSecure = true
    
    @State var showEmailAlert = false
    @State var showPasswordAlert = false
    @State var showResetAlert = false
    
    @State var emailAlertText = "Email address is required."
    
    
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
                    HStack{
                        Spacer()
                        Button {
                            withAnimation {
                                currentPage = .signup
                                isPasswordSecure = true
                            }
                            password = ""
                        } label: {
                            Text("Sign Up")
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
                            Text("Log In")
                                .font(.poppinsBold(size: 16))
                                .foregroundColor(currentPage == .signup ? Color.lightGrey : Color.mainColor)
                        }
                        Spacer()
                    }
                    
                    VStack(spacing: 20) {
                        if currentPage == .signup {
                            CustomTextField("Username", text: $username, isValidated: isUsernameValidated)
                        }
                        CustomTextField("Email", text: $email, isValidated: isEmailValidated)
                            .keyboardType(.emailAddress)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(showEmailAlert ? Color.customRed : Color.clear, lineWidth: 1)
                            )
                        if showEmailAlert {
                            Text(emailAlertText)
                                .font(.poppinsRegular(size: 12))
                                .foregroundColor(.customRed)
                                .padding(.horizontal, 13)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, -16)
                        }
                        CustomSecureField("Password", text: $password)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(showPasswordAlert ? Color.customRed : Color.clear, lineWidth: 1)
                            )
                        if showPasswordAlert {
                            Text("Password is required")
                                .font(.poppinsRegular(size: 12))
                                .foregroundColor(.customRed)
                                .padding(.horizontal, 13)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, -16)
                        }
                        
                        Button {
                            withAnimation {
                                if email.isEmpty {
                                    showEmailAlert = true
                                } else {
                                    showEmailAlert = false
                                }
                                
                                if password.isEmpty {
                                    showPasswordAlert = true
                                } else {
                                    showPasswordAlert = false
                                }
                            }
                            
                            if currentPage == .signup {
                                if isEmailValidated && isUsernameValidated && !password.isEmpty {
                                    print("Working on it")
                                    signUp(email: email, password: password) { response, error in
                                        if let response = response {
                                            print("SIGN UP RESPONSE: ", response)
                                        }
                                    }
                                }
                            } else if currentPage == .signin {
                                if !email.isEmpty && !password.isEmpty {
                                    signIn(email: email, password: password)
                                }
                            }
                            
                            
                        } label: {
                            CustomLargeButton(title: currentPage == .signup ? "Sign up" : "Sign in", foreground: .white, background: .mainColor)
                        }
                        .padding(.top, 4)
                        
                        if currentPage == .signin {
                            Button {
                                withAnimation {
                                    showResetAlert = true
                                }
                            } label: {
                                Text("Forgot Password?")
                                    .foregroundColor(.softBlue)
                            }
                            .transition(.move(edge: .bottom))
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 260)
            }
            .overlay{
                if showResetAlert {
                    ZStack {
                        Color.black.opacity(0.3)
                        
                        VStack(spacing: 24) {
                            VStack (spacing: 16) {
                                Text("Reset password")
                                    .font(.poppinsBold(size: 22))
                                    .foregroundColor(.customBlack)
                                
                                Text("Are you sure you want to reset a password?")
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
                                            Text("Cancel")
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
                                            Text("Yes")
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
        }
    }
    
    func CustomTextField(_ placeholder: String, text: Binding<String>, isValidated: Bool) -> some View {
        TextField(placeholder, text: text)
            .frame(height: 55)
            .padding(.horizontal, 13)
            .padding(.trailing, isValidated ? 27 : 0)
            .background(Color.containerGrey.cornerRadius(15))
            .overlay(
                Image(systemName: isValidated ? "checkmark" : "")
                    .foregroundColor(.checkMarkColor)
                    .padding(.trailing, 14)
                , alignment: .trailing
            )
            .onChange(of: text.wrappedValue) { newValue in
                withAnimation {
                    if placeholder == "Username" && currentPage == .signup {
                        ServiceAPI.shared.checkUsernameAvailability(username: username) { response, error in
                            if let response = response {
                                isUsernameValidated = response
                            } else {
                                isUsernameValidated = false
                            }
                        }
                    } else if placeholder == "Email" && currentPage == .signup {
                        ServiceAPI.shared.checkEmailAvailability(email: email) { response, error in
                            if let response = response {
                                isEmailValidated = response
                            } else {
                                isEmailValidated = false
                            }
                        }
                    }
                    
                    if email.isEmpty {
                        emailAlertText = "Email address is required."
                        showEmailAlert = true
                    } else if !isEmailValidated {
                        print(email)
                        emailAlertText = "You have to provide correct email address."
                        showEmailAlert = true
                    } else {
                        showEmailAlert = false
                    }
                }
            }
            .textInputAutocapitalization(.never)
    }
    
    func CustomSecureField(_ placeholder: String, text: Binding<String>) -> some View {
        ZStack {
            if isPasswordSecure {
                SecureField(placeholder, text: $password)
            } else {
                TextField(placeholder, text: $password)
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
        .textInputAutocapitalization(.never)
        .onChange(of: password) { newValue in
            withAnimation {
                if password.isEmpty {
                    showPasswordAlert = true
                } else {
                    showPasswordAlert = false
                }
            }
        }
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
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
            } else {
                guard let user = authResult?.user else {
                    print("User not found after sign-in")
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
                
                // Additional code after successful sign-in
                
                print("Sign-in successful")
            }
        }
    }
}

struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
    }
}
