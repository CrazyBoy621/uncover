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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("add_books_to_collection".localized)
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    PublishingCollectionsView()
                } label: {
                    Text("next".localized)
                        .font(.poppinsSemiBold(size: 16))
                }
            }
        }
    }
    
    @ViewBuilder func SearchField() -> some View {
        HStack(spacing: 12) {
            Image("search")
            TextField("search_books".localized, text: $searchValue)
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
                    (Text(hiddenBooks ? "show_added_books".localized.uppercased() : "hide_added_books".localized.uppercased()) + Text(" (19)"))
                        .font(.system(size: 14, weight: .bold))
                    Image(systemName: "chevron.up")
                        .rotationEffect(Angle(degrees: hiddenBooks ? 180 : 0))
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
                                BookCard(title: "Pet Semata", imgUrl: "https://s3-alpha-sig.figma.com/img/c460/2d86/d20ca040e5d10d05a84a97f0f083e217?Expires=1686528000&Signature=jl-CNaJrlIcoCOf6lHTs6nozAF-9nN6LPD5fn8hzkfC~L6yOLTVKs0OCzpeen5hUtYs~4HuxZHnzk5LSHqR2MF6gLWVYUUzJDjsRPeLZ7yeWSppqkmH2xY-8SRm1UgFHOaGyF4en7hP2Q02tgLWOkhBVpQdlQwfhGHyCIke1asEkmfFjHqitFgcNMmMjGpfmQqx9nKHeqWJhS1PwEVfspUEQYfaZfZhX8XaTUTd-K5RIa0pLt0wjbm4dxAsTBdpsHgiIZK8dBuz-0BE3JJq9KyHJQBygVxt~awd5krAab8INOBXrqxPy6uoHLCt6ZUQRpViN2YSHMuFByIAtZGVPhQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4")
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
        NavigationView {
            AddBooksToCollectionView()
        }
    }
}
