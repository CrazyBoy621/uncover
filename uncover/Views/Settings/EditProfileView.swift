//
//  EditProfileView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 11/06/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var showUsernameView = false
    @State var showNameView = false
    @State var showUserInfoView = false
    @State var showActiveLinkView = false
    
    var usernameValue = "blabla678"
    var nameValue = "Malina Cortez"
    var infoValue = ""
    var activeLinkValue = ""
    
    var body: some View {
        ScrollView {
            NavigationLink(isActive: $showUsernameView) {
                EditUsernameView(usernameValue: usernameValue)
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showNameView) {
                EditNameView(nameValue: nameValue)
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showUserInfoView) {
                EditInfoView(infoValue: infoValue)
            } label: {
                EmptyView()
            }
            
            VStack(spacing: 24) {
                ProfileImage()
                    .padding(32)
                ProfileCell("username", usernameValue){
                    showUsernameView = true
                }
                ProfileCell("name", nameValue){
                    showNameView = true
                }
                ProfileCell("info", infoValue, "Write smth about yourself..."){
                    showUserInfoView = true
                }
                ProfileCell("active link", activeLinkValue, "Add one active link..."){
                    showActiveLinkView = true
                }
            }
            .padding(.horizontal, 32)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit Profile")
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
    
    @ViewBuilder func ProfileImage() -> some View {
        Circle()
            .fill(Color.backgroundGrey)
            .frame(width: 80, height: 80)
            .overlay(
                Image(systemName: "camera.fill")
                    .font(.title)
                    .foregroundColor(.white)
            )
            .overlay(
                Circle()
                    .fill(Color.mainColor)
                    .frame(width: 28, height: 28)
                    .padding(2)
                    .background(Color.white.cornerRadius(16))
                    .overlay(
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    )
                , alignment: .bottomTrailing
            )
    }
    
    @ViewBuilder func ProfileCell(_ label: String, _ value: String, _ placeholder: String? = nil, completion: @escaping ()->()) -> some View {
        VStack(spacing: 8) {
            Text(label.uppercased())
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.lightGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                completion()
            } label: {
                HStack {
                    if value.count > 0 {
                        Text(value)
                    } else {
                        Text(placeholder ?? "")
                            .foregroundColor(.darkGrey)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.customBlack)
            }
            Divider()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileView()
        }
    }
}
