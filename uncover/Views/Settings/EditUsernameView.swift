//
//  EditUsernameView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 11/06/23.
//

import SwiftUI

struct EditUsernameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var usernameValue: String
    @State var isUsernameAvailable = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("username".localized.uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("username".localized, text: $usernameValue)
                        .autocapitalization(.none)
                        .onAppear{
                            checkAvailability()
                        }
                        .onChange(of: usernameValue) { newValue in
                            checkAvailability()
                        }
                    if isUsernameAvailable {
                        Image(systemName: "checkmark")
                            .foregroundColor(.checkMarkColor)
                            .padding(.trailing, 8)
                    } else {
                        Image("exclamation-mark")
                    }
                }
                Divider()
                Text(isUsernameAvailable ? "username_has_to_be_unique".localized : "this_username_is_already_taken".localized)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isUsernameAvailable ? .backgroundGrey : .customRed)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
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
                    Text("edit_username".localized)
                        .font(.poppinsBold(size: 20))
                        .foregroundColor(.customBlack)
                }
            }
    }
    
    func checkAvailability() {
        ServiceAPI.shared.checkUsernameAvailability(username: usernameValue) { response, error in
            if let response = response {
                print("Response: ", response)
                withAnimation {
                    isUsernameAvailable = response
                }
            } else {
                withAnimation {
                    isUsernameAvailable = false
                }
            }
        }
    }
}

struct EditUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditUsernameView(usernameValue: "test")
        }
    }
}
