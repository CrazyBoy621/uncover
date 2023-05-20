//
//  RegistrationView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI

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
    @State var isAlertTextVisible = false
    @State var isPasswordSecure = true
    
    
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
            ScrollView{
                VStack(spacing: 16) {
                    HStack{
                        Spacer()
                        Button {
                            currentPage = .signup
                            isPasswordSecure = true
                            password = ""
                        } label: {
                            Text("Sign Up")
                                .font(.poppinsBold(size: 16))
                                .foregroundColor(currentPage == .signin ? Color.lightGrey : Color.accentColor)
                        }
                        Spacer()
                        Button {
                            currentPage = .signin
                            isPasswordSecure = true
                            password = ""
                        } label: {
                            Text("Log In")
                                .font(.poppinsBold(size: 16))
                                .foregroundColor(currentPage == .signup ? Color.lightGrey : Color.accentColor)
                        }
                        Spacer()
                    }
                    
                    if currentPage == .signup {
                        VStack(spacing: 20) {
                            CustomTextField("Username", text: $username, isValidated: isUsernameValidated)
                            CustomTextField("Email", text: $email, isValidated: isEmailValidated)
                            CustomSecureField("Password", text: $password)
                            
                            Button {
                                
                            } label: {
                                CustomLargeButton(title: "Sign up", foreground: .white, background: .accentColor)
                            }
                            .padding(.top, 4)
                        }
                    }
                    else{
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                CustomTextField("Email", text: $email, isValidated: false)
                                    .onChange(of: email, perform: { newValue in
                                        withAnimation {
                                            isAlertTextVisible = newValue.isEmpty
                                        }
                                    })
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(isAlertTextVisible ? Color.customRed : Color.clear, lineWidth: 1)
                                    )
                                
                                if isAlertTextVisible {
                                    Text("email adress is required")
                                        .font(.poppinsRegular(size: 12))
                                        .foregroundColor(.customRed)
                                        .padding(.horizontal, 13)
                                }
                            }
                            CustomSecureField("Password", text: $password)
                            Button {
                                withAnimation {
                                    isAlertTextVisible = email.isEmpty
                                }
                            } label: {
                                CustomLargeButton(title: "Sign in", foreground: .white, background: .accentColor)
                            }
                            .padding(.vertical, 4)
                            
                            Button {
                                
                            } label: {
                                Text("Forgot Password?")
                                    .foregroundColor(.softBlue)
                            }
                        }
                        
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 260)
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
                if placeholder == "Username" && currentPage == .signup {
                    validateUsername()
                } else if placeholder == "Email" && currentPage == .signup {
                    validateEmail()
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
    }
    
    func validateUsername() {
        let characterCount = username.count
        let containsNumber = username.rangeOfCharacter(from: .decimalDigits) != nil
        
        if characterCount >= 8 && containsNumber {
            isUsernameValidated = true
        } else {
            isUsernameValidated = false
        }
    }
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if emailPredicate.evaluate(with: email) {
            isEmailValidated = true
        } else {
            isEmailValidated = false
        }
    }
}

struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
    }
}
