//
//  SearchingView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 22/05/23.
//

import SwiftUI

struct SearchingView: View {
    
    @State private var selectedTab: Tab = .books
    
    enum Tab {
        case books
        case collections
        case tags
        case users
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeaderSearchView()
            
            Divider()
            
            TabView(selection: $selectedTab) {
                Group {
                    Books()
                        .tag(Tab.books)
                    Collections()
                        .tag(Tab.collections)
                    Tags()
                        .tag(Tab.tags)
                    Users()
                        .tag(Tab.users)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder func HeaderSearchView() -> some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    selectedTab = .books
                }
            } label: {
                Text("Books")
                    .font(selectedTab == .books ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                    .frame(height: 36, alignment: .leading)
                    .overlay(
                        Rectangle()
                            .fill(selectedTab == .books ? Color.customBlack : Color.clear)
                            .frame(height: 2)
                        , alignment: .bottom
                    )
            }
            
            Spacer()
            Button {
                withAnimation {
                    selectedTab = .collections
                }
            } label: {
                Text("Collections")
                    .font(selectedTab == .collections ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                    .frame(height: 36, alignment: .leading)
                    .overlay(
                        Rectangle()
                            .fill(selectedTab == .collections ? Color.customBlack : Color.clear)
                            .frame(height: 2)
                        , alignment: .bottom
                    )
            }
            
            Spacer()
            Button {
                withAnimation {
                    selectedTab = .tags
                }
            } label: {
                Text("Tags")
                    .font(selectedTab == .tags ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                    .frame(height: 36, alignment: .leading)
                    .overlay(
                        Rectangle()
                            .fill(selectedTab == .tags ? Color.customBlack : Color.clear)
                            .frame(height: 2)
                        , alignment: .bottom
                    )
            }
            
            Spacer()
            Button {
                withAnimation {
                    selectedTab = .users
                }
            } label: {
                Text("Users")
                    .font(selectedTab == .users ? .poppinsBold(size: 16) : .poppinsMedium(size: 16))
                    .frame(height: 36, alignment: .leading)
                    .overlay(
                        Rectangle()
                            .fill(selectedTab == .users ? Color.customBlack : Color.clear)
                            .frame(height: 2)
                        , alignment: .bottom
                    )
            }
            Spacer()
        }
        .font(.poppinsMedium(size: 16))
        .foregroundColor(.customBlack)
        .padding(.top, 16)
    }
    
    @ViewBuilder func Books() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Popular new releases")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsBold(size: 20))
                
                LazyVGrid(columns:
                            [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 10) {
                                ForEach(1...20, id: \.self) { index in
                                    BookCard(title: "Pet Semata", imgUrl: "https://shorturl.at/kxKLT")
                                }
                            }
                            .padding(.bottom, 106)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
    }
    
    @ViewBuilder func BookCard(title: String, imgUrl: String) -> some View {
        VStack{
            WebImageView(url: URL(string: imgUrl), defaultImage: "square.fill")
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 140)
                .cornerRadius(8)
            Text(title.prefix(10) + (title.count > 10 ? "..." : ""))
                .lineLimit(1)
        }
    }
    
    @ViewBuilder func Collections() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Popular collections")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsBold(size: 20))
                
                LazyVStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        CollectionDeckView(title: "Juicy Books", username: "thisisparadise", collectionUrl: "https://shorturl.at/cBMU1", userAvatarUrl: "https://shorturl.at/euEST", rating: 99)
                        
                        CollectionDeckView(title: "Halloween reads", username: "thisisbekzod", collectionUrl: "https://shorturl.at/ejqGM", userAvatarUrl: "https://shorturl.at/euEST", rating: 12934)
                    }
                }
                .padding(.bottom, 106)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
    }
    
    @ViewBuilder func Tags() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Popular tags")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsBold(size: 20))
                
                LazyVStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        TagView(tagName: "Bekzod", tagCount: "3453")
                    }
                }
                .padding(.bottom, 106)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
    }
    
    @ViewBuilder func TagView(tagName: String, tagCount: String) -> some View{
        HStack(spacing: 16) {
            Circle()
                .fill(Color.mainColor)
                .frame(width: 48, height: 48)
                .overlay(
                    Image("hash-icon")
                        .resizable()
                        .frame(width: 21.96, height: 19.2)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text("#" + tagName)
                    .font(.system(size: 16, weight: .bold))
                Text(tagCount + " Results")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder func Users() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Popular users")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsBold(size: 20))
                
                LazyVStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        UserProfileView(profileImg: "https://shorturl.at/ouC28", userName: "bekzodrakhmatoff", fullName: "Bekzod Rakhmatov", isFollowing: false)
                        
                    }
                    
                    UserProfileView(profileImg: "https://shorturl.at/dqxW5", userName: "reader0567", fullName: "", isFollowing: true)
                    
                    UserProfileView(profileImg: "https://shorturl.at/hju23", userName: "spicybooks", fullName: "Rue 👄", isFollowing: false)

                }
                .padding(.bottom, 106)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
    }
    
    @ViewBuilder func UserProfileView(profileImg: String, userName: String, fullName: String, isFollowing: Bool) -> some View{
        HStack(spacing: 16) {
            WebImageView(url: URL(string: profileImg))
                .frame(width: 48, height: 48)
                .background(Color.darkGrey)
                .cornerRadius(24)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(userName)
                    .font(.system(size: 16, weight: .bold))
                Text(fullName)
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 14, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                
            } label: {
                Text(isFollowing ? "Following" : "Follow")
                    .font(.poppinsSemiBold(size: 14))
                    .foregroundColor(isFollowing ? .customPink : .white)
                    .frame(width: 80, height: 28)
                    .background(isFollowing ? Color.lightPink : Color.customPink)
                    .cornerRadius(16)
            }

        }
    }
}

struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView()
    }
}
