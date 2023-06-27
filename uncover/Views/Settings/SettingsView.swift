//
//  SettingsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 11/06/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                NavigationLink {
                    EditProfileView()
                } label: {
                    SettingCell("square.and.pencil", "edit_profile".localized)
                }
                NavigationLink {
                    AccountView()
                } label: {
                    SettingCell("person.fill", "account".localized)
                }
                NavigationLink {
                    NotificationSettingsView()
                } label: {
                    SettingCell("bell", "notifications".localized)
                }
                Button {
                    
                } label: {
                    SettingCell("square.and.arrow.up", "share_uncover_with_friends".localized)
                }
                Button {
                    
                } label: {
                    SettingCell("link", "profile_link".localized)
                }
                Button {
                    
                } label: {
                    SettingCell("folder.badge.plus", "add_missing_book_manually".localized)
                }
                Button {
                } label: {
                    SettingCell("questionmark.bubble", "help".localized)
                }
                NavigationLink {
                    InfoView()
                } label: {
                    SettingCell("doc.text", "info".localized)
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 48)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.customBlack)
            
            Divider()
            Button {
                
            } label: {
                SettingCell("rectangle.portrait.and.arrow.forward", "log_out".localized)
                    .foregroundColor(.customRed)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 20)
            }
            Divider()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("settings".localized)
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
