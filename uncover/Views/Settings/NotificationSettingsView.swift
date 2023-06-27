//
//  NotificationSettingsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/06/23.
//

import SwiftUI

struct NotificationSettingsView: View {
    
    @State var updateFromUncover = true
    @State var profileFollowers = true
    @State var collectionLikes = true
    @State var collectionFollowers = true
    @State var commentLikes = true
    @State var comments = true
    @State var commentReplies = true
    @State var userMentionInComment = true
    @State var newBooksCollection = true
    @State var youFollowBookUpdates = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Toggle(isOn: $updateFromUncover) {
                    Text("updates_from_uncover".localized)
                }
                Toggle(isOn: $profileFollowers) {
                    Text("profile_followers".localized)
                }
                Toggle(isOn: $collectionLikes) {
                    Text("collection_likes".localized)
                }
                Toggle(isOn: $collectionFollowers) {
                    Text("collection_followers".localized)
                }
                Toggle(isOn: $commentLikes) {
                    Text("comment_likes".localized)
                }
                Toggle(isOn: $comments) {
                    Text("comments".localized)
                }
                Toggle(isOn: $commentReplies) {
                    Text("comment_replies".localized)
                }
                Toggle(isOn: $userMentionInComment) {
                    Text("user_mentioning_you_in_comments".localized)
                }
                Toggle(isOn: $newBooksCollection) {
                    Text("new_books_showing_up_in_collections_you_follow".localized)
                }
                Toggle(isOn: $youFollowBookUpdates) {
                    Text("updates_collections_from_followed_users".localized)
                }
            }
            .tint(.mainColor)
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.customBlack)
            .padding(32)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("notifications".localized)
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
}

struct NotificationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationSettingsView()
        }
        .accentColor(.mainColor)
    }
}
