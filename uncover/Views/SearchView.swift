//
//  SearchView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI
import UIKit

struct SearchView: View {
    
    
    @State var isSearching = false
    @State var searchValue = ""
    @State var searchPlaceholder = "search".localized
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                if !isSearching {
                    HStack {
                        Text("discover_your_new_reads".localized)
                            .font(.poppinsBold(size: 28))
                            .foregroundColor(.customBlack)
                            .frame(maxWidth: 295, alignment: .leading)
                        
                        Spacer()
                    }
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                }
                
                HStack {
                    if isSearching {
                        Button {
                            withAnimation {
                                searchPlaceholder = "search".localized
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
                                    searchPlaceholder = "search_by_title_and_author".localized
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
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                } else {
                    ScrollView {
                        SearchView()
                            .padding(.bottom, 106)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitleDisplayMode(.inline)
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
                CollectionTitle(title: "book_trends".localized)
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
                CollectionTitle(title: "fantasy_collections".localized)
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
                CollectionTitle(title: "mystery_and_crime".localized)
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
    }
}
