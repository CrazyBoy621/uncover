//
//  ChangePasswordView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/06/23.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var oldPassword = ""
    @State var isOldPasswordSecure = true
    @State var newPassword = ""
    @State var isNewPasswordSecure = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("old password".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                PasswordTextField("Old Password", value: $oldPassword, isSecure: $isOldPasswordSecure)
                Divider()
                
                Text("new password".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                PasswordTextField("New Password", value: $newPassword, isSecure: $isNewPasswordSecure)
                Divider()
                
                HStack(spacing: 16) {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        CustomButton(title: "Cancel", foreground: .softBlue, background: .white)
                    }
                    Button {
                        
                    } label: {
                        CustomButton(title: "Done", foreground: .white, background: .mainColor)
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
                Text("Change Password")
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
    
    @ViewBuilder func PasswordTextField(_ placeholder: String, value: Binding<String>, isSecure: Binding<Bool>) -> some View {
        ZStack {
            if isSecure.wrappedValue {
                SecureField(placeholder, text: value)
            } else {
                TextField(placeholder, text: value)
            }
        }
        .padding(.trailing, 48)
        .overlay(
            Button {
                withAnimation {
                    isSecure.wrappedValue.toggle()
                }
            } label: {
                Image(systemName: isSecure.wrappedValue ? "eye.slash" : "eye")
                    .foregroundColor(.lightGrey)
                    .padding(.trailing, 14)
            }
            , alignment: .trailing
        )
        .disableAutocorrection(true)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChangePasswordView()
        }
    }
}
