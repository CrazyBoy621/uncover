//
//  ChangeEmailView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/06/23.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var email: String = ""
    @State var isEmailValidated = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("name".localized.uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    CustomTextField("email".localized, value: $email)
                }
                Divider()
                
                HStack(spacing: 16) {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        CustomButton(title: "cancel".localized, foreground: .softBlue, background: .white)
                    }
                    Button {
                        
                    } label: {
                        CustomButton(title: "done".localized, foreground: .white, background: .mainColor)
                    }
                    
                }
                .padding(.top, 24)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 32)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("change_email".localized)
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
    
    func CustomTextField(_ placeholder: String, value: Binding<String>) -> some View {
        TextField(placeholder, text: value)
            .padding(.trailing, isEmailValidated ? 27 : 0)
            .overlay(
                Image(systemName: isEmailValidated ? "checkmark" : "")
                    .foregroundColor(.checkMarkColor)
                    .padding(.trailing, 14)
                , alignment: .trailing
            )
            .onChange(of: value.wrappedValue) { newValue in
                validateEmail()
            }
            .onAppear{
                validateEmail()
            }
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
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

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView(email: "custom@gmail.com")
    }
}
