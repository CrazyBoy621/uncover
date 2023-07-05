//
//  BooksCollectionView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/05/23.
//

import SwiftUI

struct BooksCollectionView: View {
    var body: some View {
        VStack(spacing: 16) {
            NavigationLink {
                UserBooksView()
            } label: {
                CollectionTitle(title: "books".localized)
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
                .padding(.horizontal, 16)
                .frame(height: 166)
            }
        }
    }
}

struct BooksCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        BooksCollectionView()
    }
}
