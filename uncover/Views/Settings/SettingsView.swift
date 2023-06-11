//
//  SettingsView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 11/06/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                NavigationLink {
                    EditProfileView()
                } label: {
                    SettingCell("square.and.pencil", "Edit Profile")
                }
                NavigationLink {
                    AccountView()
                } label: {
                    SettingCell("person.fill", "Account")
                }
                NavigationLink {
                    NotificationSettingsView()
                } label: {
                    SettingCell("bell", "Notifications")
                }
                Button {
                    
                } label: {
                    SettingCell("square.and.arrow.up", "Share Uncover with friends")
                }
                Button {
                    
                } label: {
                    SettingCell("link", "Profile link")
                }
                Button {
                    
                } label: {
                    SettingCell("folder.badge.plus", "Add missing book manually")
                }
                Button {
                } label: {
                    SettingCell("questionmark.bubble", "Help")
                }
                NavigationLink {
                    InfoView()
                } label: {
                    SettingCell("doc.text", "Info")
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 48)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.customBlack)
            
            Divider()
            Button {
                
            } label: {
                SettingCell("rectangle.portrait.and.arrow.forward", "Log out")
                    .foregroundColor(.customRed)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 20)
            }
            Divider()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
    
    @ViewBuilder func SettingCell(_ imgName: String, _ text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: imgName)
            Text(text)
                .font(.system(size: 16, weight: .medium))
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
