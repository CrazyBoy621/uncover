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
                    Text("Updates from Uncover team")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("Profile followers")
                }
                Toggle(isOn: $collectionLikes) {
                    Text("Collection likes")
                }
                Toggle(isOn: $collectionFollowers) {
                    Text("Collection followers")
                }
                Toggle(isOn: $commentLikes) {
                    Text("Comment likes")
                }
                Toggle(isOn: $comments) {
                    Text("Comments")
                }
                Toggle(isOn: $commentReplies) {
                    Text("Comment replies")
                }
                Toggle(isOn: $userMentionInComment) {
                    Text("User mentioning you in comments")
                }
                Toggle(isOn: $newBooksCollection) {
                    Text("New books showing up in collections you follow")
                }
                Toggle(isOn: $youFollowBookUpdates) {
                    Text("Book updates or collections created by users you follow")
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
                Text("Notifications")
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
