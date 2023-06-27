//
//  AccountView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/06/23.
//

import SwiftUI

struct AccountView: View {
    
    @State var showChangeEmailView = false
    @State var showChangePasswordView = false
    
    var body: some View {
        ScrollView {
            NavigationLink(isActive: $showChangeEmailView) {
                ChangeEmailView()
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showChangePasswordView) {
                ChangePasswordView()
            } label: {
                EmptyView()
            }
            
            VStack(spacing: 24) {
                ProfileCell("email".localized, "change_email".localized){
                    showChangeEmailView = true
                }
                ProfileCell("password".localized, "change_password".localized){
                    showChangePasswordView = true
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 32)
            .padding(.bottom, 48)
            
            Divider()
            Button {
                
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                    Text("deactivate_the_account".localized)
                    Spacer()
                }
                .foregroundColor(.customRed)
                .padding(.horizontal, 32)
                .padding(.vertical, 20)
            }
            Divider()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("account".localized)
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
    
    @ViewBuilder func ProfileCell(_ label: String, _ value: String, completion: @escaping ()->()) -> some View {
        VStack(spacing: 8) {
            Text(label.uppercased())
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.lightGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                completion()
            } label: {
                HStack {
                    Text(value)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.customBlack)
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountView()
        }
    }
}
