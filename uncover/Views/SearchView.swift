//
//  SearchView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var isSearching = false
    @State var searchValue = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if isSearching {
                    SearchingView()
                } else {
                    SearchDefaultView()
                }
            }
            .padding(.bottom, 106)
        }
    }
    
    @ViewBuilder func SearchDefaultView() -> some View{
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                HStack {
                    Text("Discover your new reads")
                        .font(.poppinsBold(size: 28))
                        .foregroundColor(.customBlack)
                        .frame(maxWidth: 295, alignment: .leading)
                    
                    Spacer()
                }
                
                SearchTextField(placeholder: "Search...", text: $searchValue)
                    .onTapGesture {
                        isSearching = true
                    }
                
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            
            BookTrends()
            
            FantasyCollections()
            
            MysteryAndCrime()
        }
    }
    
    @ViewBuilder func BookTrends() -> some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                CollectionTitle(title: "Book trends")
            }
            .padding(.trailing, 16)
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
                .frame(height: 166)
            }
        }
        .padding(.leading, 16)
    }
    
    @ViewBuilder func FantasyCollections() -> some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                CollectionTitle(title: "Fantasy Collections")
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
                CollectionTitle(title: "Mystery & Crime")
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
    
    @ViewBuilder func SearchingView() -> some View{
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    withAnimation {
                        isSearching = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.lightGrey)
                        .font(.title)
                }
                
                SearchTextField(placeholder: "Search by title & author...", text: $searchValue)
            }
        }
        .padding(16)
    }
    
    @ViewBuilder func SearchTextField(placeholder: String, text: Binding<String>) -> some View{
        TextField(placeholder, text: text)
            .frame(maxWidth: .infinity)
            .padding(.leading, 50)
            .frame(height: 55)
            .background(Color.containerGrey.cornerRadius(14))
            .overlay(
                Image(systemName: "magnifyingglass")
                    .padding(.horizontal, 12)
                    .font(.title2)
                    .foregroundColor(.darkGrey)
                , alignment: .leading
            )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
    }
}
