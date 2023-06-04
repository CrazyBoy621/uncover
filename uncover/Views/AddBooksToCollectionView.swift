//
//  AddBooksToCollectionView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 03/06/23.
//

import SwiftUI

struct AddBooksToCollectionView: View {
    
    @State var searchValue = ""
    @State var hiddenBooks = true
    
    var body: some View {
        VStack(spacing: 18) {
            SearchField()
            AddedBooks()
            BooksSelection()
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
                withAnimation {
                    hiddenBooks.toggle()
                }
            } label: {
                HStack {
                    Text("Hide added books (19)".uppercased())
                        .font(.system(size: 14, weight: .bold))
                    Image(systemName: "chevron.up")
                        .rotationEffect(Angle(degrees: hiddenBooks ? 0 : 180))
                    Spacer()
                }
                .foregroundColor(.darkGrey)
                .padding(.horizontal, 14)
            }
            
            if !hiddenBooks {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(1...20, id: \.self) { index in
                            Image("background-img")
                                .resizable()
                                .frame(width: 60, height: 92.66)
                                .cornerRadius(8)
                                .overlay (
                                    Button{
                                        
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.customRed)
                                            .padding(2)
                                            .background(
                                                Color.white.cornerRadius(15)
                                            )
                                            .padding(-5)
                                    }
                                    , alignment: .topTrailing
                                )
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 100)
            }
            
            Divider()
        }
    }
    
    @ViewBuilder func BooksSelection() -> some View {
        ScrollView {
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
}

struct AddBooksToCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddBooksToCollectionView()
    }
}
