//
//  NotificationView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 15/05/23.
//

import SwiftUI

struct NotificationView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    NotificationTitle(title: "New")
                    VStack(spacing: 12) {
                        LikedCollectionNotification(userImgURL: "https://shorturl.at/egvCO", userName: "Bekzod", collectionImgURL: "https://shorturl.at/tBDV4")
                        SharedCollectionNotification(userImgURL: "https://shorturl.at/egvCO", userName: "Bekzod", collectionImgURL: "https://shorturl.at/tBDV4")
                        FollowedNotification(userImgURL: "https://shorturl.at/egvCO", userName: "Bekzod")
                    }
                    .padding(.bottom)
                    
                    NotificationTitle(title: "Recent")
                    VStack {
                        RepliedCommentInCollection(userImgURL: "https://shorturl.at/egvCO", userName: "Bekzod", collectionImgURL: "https://shorturl.at/tBDV4")
                        
                        RepliedYourComment(userImgURL: "https://shorturl.at/egvCO", userName: "Bekzod", collectionImgURL: "https://shorturl.at/tBDV4")
                        
                        YourFacebookFriendNotification(userImgURL: "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg", userName: "Anna")
                        YourFacebookFriendNotification(userImgURL: "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg", userName: "Anna")
                        YourFacebookFriendNotification(userImgURL: "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg", userName: "Anna")
                        YourFacebookFriendNotification(userImgURL: "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg", userName: "Anna")
                        YourFacebookFriendNotification(userImgURL: "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg", userName: "Anna")
                        YourFacebookFriendNotification(userImgURL: "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg", userName: "Anna")
                        YourFacebookFriendNotification(userImgURL: "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg", userName: "Anna")
                    }
                }
                .padding()
                .padding(.bottom, 106)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Text("Notification")
                            .font(.poppinsExtraBold(size: 20))
                        Text("20+")
                            .font(.robotoMedium(size: 14))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 3)
                            .background {
                                Color.customPink.cornerRadius(11)
                            }
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    @ViewBuilder func NotificationTitle(title: String) -> some View{
        Text(title)
            .font(.poppinsBold(size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 6)
    }
    
    @ViewBuilder func EmptyNotification() -> some View {
        ScrollView {
            VStack {
                ZStack {
                    Image("empty-background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                    Image("empty-notification")
                }
                
                VStack(spacing: 11) {
                    Text("It's lonely here")
                        .font(.poppinsRegular(size: 28))
                    
                    VStack {
                        Text("There is nothing here, yet :(")
                        Text("Let’s find you some interesting collections to follow!")
                    }
                    .foregroundColor(.darkGrey)
                    .multilineTextAlignment(.center)
                    .font(.poppinsRegular(size: 16))
                }
                .padding(.horizontal, 16)
                
                Button {
                    
                } label: {
                    CustomLargeButton(title: "Explore", foreground: .white, background: .accentColor)
                        .padding(24)
                }
            }
            .padding(.bottom, 106)
        }
        .offset(y: -100)
    }
    
    @ViewBuilder func LikedCollectionNotification(userImgURL:String, userName: String, collectionImgURL: String) -> some View{
        VStack(spacing: 4){
            Text("2 hours ago")
                .foregroundColor(.darkGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 16) {
                WebImageView(url: URL(string: userImgURL), defaultImage: "person.circle")
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        Circle()
                            .fill(Color.customPink)
                            .frame(width: 12, height: 12)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 16, height: 16)
                            )
                            .overlay(
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(.white)
                                , alignment: .center
                            )
                        ,alignment: .bottomTrailing
                    )
                (Text(userName)
                    .font(.system(size: 14, weight: .bold)) +
                 Text(" liked your collection")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                WebImageView(url: URL(string: collectionImgURL), defaultImage: "photo")
                    .frame(width: 65, height: 65)
                    .clipped()
                    .cornerRadius(16)
            }
        }
    }
    
    @ViewBuilder func SharedCollectionNotification(userImgURL:String, userName: String, collectionImgURL: String) -> some View{
        VStack(spacing: 4){
            Text("3 hours ago")
                .foregroundColor(.darkGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 16) {
                WebImageView(url: URL(string: userImgURL), defaultImage: "person.circle")
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 12, height: 12)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 16, height: 16)
                            )
                            .overlay(
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(.white)
                                , alignment: .center
                            )
                        ,alignment: .bottomTrailing
                    )
                
                (Text(userName)
                    .font(.system(size: 14, weight: .bold)) +
                 Text(" shared your collection")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                
                WebImageView(url: URL(string: collectionImgURL), defaultImage: "photo")
                    .frame(width: 65, height: 65)
                    .clipped()
                    .cornerRadius(16)
            }
        }
    }
    
    @ViewBuilder func FollowedNotification(userImgURL:String, userName: String) -> some View{
        VStack(spacing: 4){
            Text("3 hours ago")
                .foregroundColor(.darkGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 16) {
                WebImageView(url: URL(string: userImgURL), defaultImage: "person.circle")
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 12, height: 12)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 16, height: 16)
                            )
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 6, weight: .heavy))
                                    .foregroundColor(.white)
                                , alignment: .center
                            )
                        ,alignment: .bottomTrailing
                    )
                
                (Text(userName)
                    .font(.system(size: 14, weight: .bold)) +
                 Text(" followed you")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                
                CustomSmallButton(title: "Following", foreground: .customPink, background: .lightPink)
            }
        }
    }
    
    @ViewBuilder func RepliedCommentInCollection(userImgURL:String, userName: String, collectionImgURL: String) -> some View{
        VStack(spacing: 4){
            Text("1 week ago")
                .foregroundColor(.darkGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 16) {
                WebImageView(url: URL(string: userImgURL), defaultImage: "person.circle")
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        Image("comment-icon")
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 16, height: 16)
                            )
                        ,alignment: .bottomTrailing
                    )
                
                (Text(userName)
                    .font(.system(size: 14, weight: .bold)) +
                 Text(" and ")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)) +
                 Text("4 others")
                    .font(.system(size: 14, weight: .bold)) +
                 Text(" replied to your comment in your collection")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                
                WebImageView(url: URL(string: collectionImgURL), defaultImage: "photo")
                    .frame(width: 65, height: 65)
                    .clipped()
                .cornerRadius(16)            }
        }
    }
    
    @ViewBuilder func RepliedYourComment(userImgURL:String, userName: String, collectionImgURL: String) -> some View{
        VStack(spacing: 4){
            Text("1 week ago")
                .foregroundColor(.darkGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 16) {
                WebImageView(url: URL(string: userImgURL), defaultImage: "person.circle")
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        Image("comment-icon")
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 16, height: 16)
                            )
                        ,alignment: .bottomTrailing
                    )
                
                (Text(userName)
                    .font(.system(size: 14, weight: .bold)) +
                 Text(" replied to your comment")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                
                WebImageView(url: URL(string: collectionImgURL), defaultImage: "photo")
                    .frame(width: 49, height: 65)
                    .clipped()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(16)
            }
        }
    }
    
    @ViewBuilder func YourFacebookFriendNotification(userImgURL:String, userName: String) -> some View{
        VStack(spacing: 4){
            Text("1 week ago")
                .foregroundColor(.darkGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 16) {
                WebImageView(url: URL(string: userImgURL), defaultImage: "person.circle")
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 12, height: 12)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 16, height: 16)
                            )
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 6, weight: .heavy))
                                    .foregroundColor(.white)
                                , alignment: .center
                            )
                        ,alignment: .bottomTrailing
                    )
                
                (Text("Your Facebook friend ")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)) +
                 Text(userName)
                    .font(.system(size: 14, weight: .bold)) +
                 Text(" is on Uncover")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                
                Button {
                    
                } label: {
                    CustomSmallButton(title: "Follow", foreground: .white, background: .customPink)
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
