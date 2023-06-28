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
                Text("books".localized)
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
                Text("collections".localized)
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
                Text("tags".localized)
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
                Text("users".localized)
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
                Text("popular_new_releases".localized)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsBold(size: 20))
                
                LazyVGrid(columns:
                            [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 10) {
                                ForEach(1...20, id: \.self) { index in
                                    BookCard(title: "Pet Sematary", imgUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSq5Y1xYI2e_Ww5z3Z0BN0dSQxKRSbiETs-rRrJKTzZ3WWFSHl7")
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
                Text("popular_collections".localized)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsBold(size: 20))
                
                LazyVStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        CollectionDeckView(title: "Halloween reads", username: "Marry Shelley", collectionUrl: "https://hips.hearstapps.com/hmg-prod/images/halloween-books-1629065133.jpg", userAvatarUrl: "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcTbcDv4UIW6U5xvbQUGTiLjTObwcOu1siRgj8QmLr51RiDdqslShaBp6jvdwSS1qXdu4wvCHwZiS7GNfAs", rating: 99)
                        
                        CollectionDeckView(title: "Juicy Books", username: "Charles Dickens", collectionUrl: "https://www.realsimple.com/thmb/KrGb42aamhHKaMzWt1Om7U42QsY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/great-books-for-anytime-2000-4ff4221eb1e54b659689fef7d5e265d5.jpg", userAvatarUrl: "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcRg91sZUpmg92kMgbJyTzNiXuN7bK4HMgs68QiZifK5WUozc65W1VrnxmuXL8YaRHR-R8eBoeJv3VflDjw", rating: 12934)
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
                Text("popular_tags".localized)
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
                Text("popular_users".localized)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsBold(size: 20))
                
                LazyVStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        UserProfileView(profileImg: "https://i1.rgstatic.net/ii/profile.image/818545696972801-1572167910559_Q512/Bekzod-Rakhmatov.jpg", userName: "bekzodrakhmatoff", fullName: "Bekzod Rakhmatov", isFollowing: false)
                        
                    }
                    
                    UserProfileView(profileImg: "https://static.thenounproject.com/png/574704-200.png", userName: "reader0567", fullName: "", isFollowing: true)
                    
                    UserProfileView(profileImg: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRed3Mp4juMXqsLDUBgVpdLW8EjnjRmtAetGg&usqp=CAU", userName: "spicybooks", fullName: "Rue 👄", isFollowing: false)

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
                Text(isFollowing ? "following".localized : "follow".localized)
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
