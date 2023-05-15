//
//  ProfileView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/05/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State var userImage = "user-avatar"
    @State var userName = "Susan Sarandon eleven"
    @State var booksCount = 238
    @State var followersCount = 89
    @State var followingCount = 15181
    @State var infoText = "Books are my way of exploring the world. I love to travel  and cooking. Collecting recepies and books about healthy lifestyle 🍎🍀 Books are my way of exploring the world. I love to travel  and cooking. Collecting recepies and books about healthy lifestyle 🍎🍀"
    @State var isTextExpanded = false
    
    var body: some View {
        ScrollView{
            TopProfileView()
            Divider()
            BottomProfileView()
                .padding(.bottom, 106)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem{
                Button {
                    
                } label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("My Profile")
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
    }
    
    @ViewBuilder func TopProfileView() -> some View{
        VStack(spacing: 12) {
            WebImageView(url: URL(string: "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?w=2000&t=st=1684071062~exp=1684071662~hmac=c236951e514f85a8faf538d4138194110c85365768bd01d2923a654f9ba12533"), defaultImage: "user")
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(40)
            
            Text(userName)
                .foregroundColor(.customBlack)
                .font(.system(size: 16, weight: .bold))
            
            Button {
                
            } label: {
                CustomButton(title: "Edit", background: .customPink)
            }
            .frame(width: 120, height: 32)
            .padding(4)
            
            HStack(spacing: 16){
                InfoView(count: 238, title: "Books")
                InfoView(count: 89, title: "Followers")
                InfoView(count: 15181, title: "Following")
            }
            .padding(4)
            
        }
        .padding(.top, 24)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder func BottomProfileView() -> some View{
        VStack(spacing: 24){
            InfoTextView()
            BooksCollectionView()
            CollectionView()
        }
        .padding(12)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder func InfoTextView() -> some View {
        @State var expanded = false
        
        VStack(alignment: .leading, spacing: 11) {
            Text("Info")
                .foregroundColor(.customBlack)
                .font(.system(size: 20, weight: .heavy))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(infoText)
                .font(.system(size: 14))
                .foregroundColor(.customBlack)
                .lineLimit(isTextExpanded ? nil : 3)
                .padding(.top, 5)
            
            Button {
                withAnimation() {
                    isTextExpanded.toggle()
                }
            } label: {
                Text(isTextExpanded ? "Read less..." : "Read more...")
                    .foregroundColor(.lightGrey)
                    .font(.system(size: 14, weight: .heavy))
            }
        }
    }
    
    
    func InfoView(count: Int, title: String) -> some View{
        VStack(spacing: 4){
            Text("\(count)")
                .font(.system(size: 16, weight: .bold))
                .fontWeight(.heavy)
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.darkGrey)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
