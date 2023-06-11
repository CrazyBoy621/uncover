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
                Toggle(isOn: $profileFollowers) {
                    Text("Collection likes")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("Collection followers")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("Comment likes")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("Comments")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("Comment replies")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("User mentioning you in comments")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("New books showing up in collections you follow")
                }
                Toggle(isOn: $profileFollowers) {
                    Text("Book updates or collections created by users you follow")
                }
            }
            .accentColor(.mainColor)
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
