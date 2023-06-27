//
//  InfoView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/06/23.
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
                        SettingCell("terms_of_service".localized)
                    }
                }
                Button {
                    guard let url = URL(string: "https://theuncoverapp.com/privacy_policy.html") else { return }
                    UIApplication.shared.open(url)
                } label: {
                    SettingCell("privacy_policy".localized)
                }
                VStack(spacing: 8) {
                    Title("find_us".localized)
                    Button {
                        guard let url = URL(string: "https://www.theuncoverapp.com") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        SettingCell("www.theuncoverapp.com")
                    }
                }
                VStack(spacing: 8) {
                    Title("rate_us".localized)
                    Button {
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: scene)
                        }
                    } label: {
                        SettingCell("app_store".localized)
                    }
                }
            }
            .padding(32)
            
            Divider()
            Text("app_version".localized)
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
                Text("info".localized)
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
