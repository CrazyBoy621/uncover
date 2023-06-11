//
//  InfoView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 12/06/23.
//

import SwiftUI
import StoreKit

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Title("legal")
                    Button {
                        guard let url = URL(string: "https://theuncoverapp.com/terms_of_use.html") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        SettingCell("Terms of service")
                    }
                }
                Button {
                    guard let url = URL(string: "https://theuncoverapp.com/privacy_policy.html") else { return }
                    UIApplication.shared.open(url)
                } label: {
                    SettingCell("Privacy policy")
                }
                VStack(spacing: 8) {
                    Title("find us")
                    Button {
                        guard let url = URL(string: "https://www.theuncoverapp.com") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        SettingCell("www.theuncoverapp.com")
                    }
                }
                VStack(spacing: 8) {
                    Title("rate us")
                    Button {
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: scene)
                        }
                    } label: {
                        SettingCell("App Store")
                    }
                }
            }
            .padding(32)
            
            Divider()
            Text("Version 1.2")
                .foregroundColor(.mainColor)
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                .padding(.vertical, 22)
            Divider()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Info")
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
    
    @ViewBuilder func Title(_ text: String) -> some View {
        HStack {
            Text(text.uppercased())
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.lightGrey)
            Spacer()
        }
    }
    
    @ViewBuilder func SettingCell(_ value: String) -> some View {
        HStack {
            Text(value)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .font(.system(size: 16, weight: .medium))
        .foregroundColor(.customBlack)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoView()
        }
    }
}
