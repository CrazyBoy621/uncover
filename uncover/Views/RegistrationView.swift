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

struct RegistrationView: View {
    
    @State var currentPage: Registeration = .signup
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    @State var isUsernameValidated = false
    @State var isEmailValidated = false
    
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
                        } label: {
                            Text("Sign Up")
                                .font(.poppinsBold(size: 16))
                                .foregroundColor(currentPage == .signin ? Color.lightGrey : Color.accentColor)
                        }
                        Spacer()
                        Button {
                            currentPage = .signin
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
                            CustomTextField("Password", text: $password, isValidated: false)
                            
                            Button {
                                
                            } label: {
                                CustomLargeButton(title: "Sign up", foreground: .white, background: .accentColor)
                            }
                            .padding(.top, 4)
                        }
                    }
                    else{
                        VStack(spacing: 20) {
                            CustomTextField("Email", text: $email, isValidated: false)
                            CustomTextField("Password", text: $password, isValidated: false)
                            
                            Button {
                                
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("uncover-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .edgesIgnoringSafeArea(.top)
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

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
