//
//  AddBooksToCollectionView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 03/06/23.
//

import SwiftUI

struct AddBooksToCollectionView: View {
    
    @State var searchValue = ""
    @State var hiddenBooks = false
    
    var body: some View {
        VStack(spacing: 18) {
            SearchField()
            AddedBooks()
            Spacer()
        }
    }
    
    @ViewBuilder func SearchField() -> some View {
        HStack(spacing: 12) {
            Image("search")
            TextField("Search books", text: $searchValue)
        }
        .padding(16)
        .background(Color.containerGrey.cornerRadius(14))
        .padding(.horizontal)
    }
    
    @ViewBuilder func AddedBooks() -> some View {
        VStack(spacing: 16) {
            Button {
                hiddenBooks.toggle()
            } label: {
                HStack {
                    Text("Hide added books (19)".uppercased())
                        .font(.system(size: 14, weight: .bold))
                    Image(systemName: hiddenBooks ? "chevron.down" : "chevron.up")
                    Spacer()
                }
                .foregroundColor(.darkGrey)
                .padding(.horizontal, 14)
            }
            
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ScrollView(.horizontal) {
                    ForEach(1...20, id: \.self) { index in
                        Image("background-img")
                            .resizable()
                            .frame(width: 60, height: 90)
                    }
                }
                .frame(height: 100)
                .border(.blue)
            }
            .border(.red)
        }
    }
}

struct AddBooksToCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddBooksToCollectionView()
    }
}
