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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("username".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.lightGrey)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("Username", text: $usernameValue)
                }
                Divider()
                Text("Username has to be unique")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.backgroundGrey)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
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
                    Text("Edit username")
                        .font(.poppinsBold(size: 20))
                        .foregroundColor(.customBlack)
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
