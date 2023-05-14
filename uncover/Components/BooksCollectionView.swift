//
//  BooksCollectionView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 14/05/23.
//

import SwiftUI

struct BooksCollectionView: View {
    var body: some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                CollectionTitle(title: "Books")
            }
            ScrollView(.horizontal) {
                LazyHStack{
                    ForEach(0..<20) { Index in
                        Image("background-img")
                            .resizable()
                            .frame(width: 110, height: 166)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                    }
                }
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
