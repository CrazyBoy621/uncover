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
                    CollectionDeckView(title: "Re-read someday", username: "martinpalmer", collectionUrl: "https://shorturl.at/pvCDO", userAvatarUrl: "https://shorturl.at/dsEI9", rating: 99)
                }
                NavigationLink{
                    WelcomeView()
                } label: {
                    CollectionDeckView(title: "Children's literature", username: "Bekzod", collectionUrl: "https://shorturl.at/mqC56", userAvatarUrl: "https://shorturl.at/dsEI9", rating: 99)
                }
                NavigationLink {
                    BookDetailsView()
                } label: {
                    CollectionDeckView(title: "Children's literature", username: "Bekzod", collectionUrl: "https://shorturl.at/mqC56", userAvatarUrl: "https://shorturl.at/dsEI9", rating: 99)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 106)
        }
        .navigationTitle("")
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
        HomeView()
    }
}
