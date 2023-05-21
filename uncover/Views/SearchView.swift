//
//  SearchView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI
import UIKit

struct SearchView: View {
    
    
    @State var isSearching = true
    @State var searchValue = ""
    @State var searchPlaceholder = "Search"
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                if !isSearching {
                    HStack {
                        Text("Discover your new reads")
                            .font(.poppinsBold(size: 28))
                            .foregroundColor(.customBlack)
                            .frame(maxWidth: 295, alignment: .leading)
                        
                        Spacer()
                    }
                }
                
                HStack {
                    if isSearching {
                        Button {
                            withAnimation {
                                searchPlaceholder = "Search..."
                                isSearching = false
                            }
                            hideKeyboard()
                            searchValue = ""
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.customBlack)
                        }
                    }
                    
                    SearchTextField(placeholder: searchPlaceholder, text: $searchValue)
                        .onTapGesture {
                            if isSearching == false {
                                withAnimation {
                                    searchPlaceholder = "Search by title & author..."
                                    isSearching = true
                                }
                            }
                        }
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            
            VStack{
                if isSearching {
                    SearchingView()
                } else {
                    ScrollView {
                        SearchView()
                            .padding(.bottom, 106)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder func SearchView() -> some View{
        VStack(spacing: 24) {
            
            BookTrends()
            
            FantasyCollections()
            
            MysteryAndCrime()
        }
    }
    
    @ViewBuilder func BookTrends() -> some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                CollectionTitle(title: "Book trends")
            }
            .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    ForEach(0..<20) { Index in
                        Image("background-img")
                            .resizable()
                            .frame(width: 110, height: 166)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                    }
                }
                .padding(.leading, 16)
                .frame(height: 166)
            }
        }
    }
    
    @ViewBuilder func FantasyCollections() -> some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                CollectionTitle(title: "Fantasy Collections")
            }
            .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(0..<20, content: { index in
                        CollectionCard()
                    })
                }
                .padding(.bottom, 18)
                .padding(.leading, 16)
            }
        }
    }
    
    @ViewBuilder func MysteryAndCrime() -> some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                CollectionTitle(title: "Mystery & Crime")
            }
            .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(0..<20, content: { index in
                        CollectionCard()
                    })
                }
                .padding(.bottom, 18)
                .padding(.leading, 16)
            }
        }
    }
    
    @ViewBuilder func CollectionCard() -> some View{
        ZStack(alignment: .top) {
            Image("background-img")
                .resizable()
                .frame(width: 167, height: 206)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(18)
                .overlay (
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.1),
                                    Color.black.opacity(0)]),
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(height: 76)
                    , alignment: .top
                )
            
            Text("Chemistry studies")
                .font(.system(size: 14, weight: .heavy))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.3), radius: 4, y: 4)
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
        }
        .shadow(color: .black.opacity(0.3), radius: 4, y: 4)
    }
    
    func hideKeyboard() {
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            return
        }
        
        keyWindow.endEditing(true)
    }
}

struct SearchingView: View {
    @State private var selectedTab: Tab = .users
    
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
    
    @ViewBuilder func BookCard(title: String, imgUrl: String) -> some View{
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
                        TagView(tagName: "Shohjahon", tagCount: "3453")
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
                .fill(Color.accentColor)
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
    }
}
