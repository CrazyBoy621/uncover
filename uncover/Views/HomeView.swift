//
//  HomeView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24){
                NavigationLink {
                    CollectionWithDescriptionView()
                } label: {
                    CollectionDeckView(title: "Re-read someday", username: "martinpalmer", collectionUrl: "https://plus.unsplash.com/premium_photo-1677567996070-68fa4181775a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2344&q=80", userAvatarUrl: "https://davidoyebolu.com/wp-content/uploads/2023/03/istockphoto-1332653761-170667a.jpg", rating: 99)
                }
                NavigationLink{
                    WelcomeView()
                } label: {
                    CollectionDeckView(title: "Children's literature", username: "Bekzod", collectionUrl: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1528&q=80", userAvatarUrl: "https://media.istockphoto.com/id/813935198/photo/smiling-man-in-the-living-room-is-taking-a-selfie.jpg?s=612x612&w=0&k=20&c=BvF2uMhiEFNFSERoEa0ug2qzd8Fg8OFT60Z6FcaVvzw=", rating: 99)
                }
                NavigationLink {
                    BookDetailsView()
                } label: {
                    CollectionDeckView(title: "Children's literature", username: "Bekzod", collectionUrl: "https://images.unsplash.com/photo-1580537659466-0a9bfa916a54?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80", userAvatarUrl: "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png", rating: 99)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 106)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("uncover-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
