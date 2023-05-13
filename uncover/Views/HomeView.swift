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
                    BookDetailView()
                } label: {
                    BookDeckView(title: "Learn Today!", username: "Bekzod", rating: 2005)
                }                
                BookDeckView(title: "Children’s literature", username: "Bekzod", rating: 1996)
            }
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
