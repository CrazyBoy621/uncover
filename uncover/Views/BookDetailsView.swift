//
//  BookDetailsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 17/05/23.
//

import SwiftUI

struct BookDetailsView: View {
    
    @State var isDescriptionExpanded = false
    @State var index = 0
    
    @State var commentText = ""
    
    let comments: [Comment] = [
        Comment(username: "ninasmith", userIMG: "https://shorturl.at/bfvFK", commentText: "Beautiful love story with the twist. You want expect the ending! One of the best book by this author. I really like her... more", likesCount: "12 likes", time: "1 hour ago", replies: []),
        Comment(username: "msvitton", userIMG: "https://shorturl.at/fwzY6", commentText: "Do you agree that in this book was a little to much of an obscene conversations?", likesCount: "100k likes", time: "8 hours ago", replies: [
            Comment(username: "sunsethunter", userIMG: "https://shorturl.at/ainpX", commentText: "Maybe... for me it was fun do 🐸 ", likesCount: "10 likes", time: "6 hours ago", replies: []),
            Comment(username: "hufflepuffforever", userIMG: "https://shorturl.at/qFM14", commentText: "ehhh.... little sex never killed nobody :p girl is creative, that’s all xD", likesCount: "0 like", time: "6 hours ago", replies: []),
            Comment(username: "hufflepuffforever", userIMG: "https://shorturl.at/qFM14", commentText: "ehhh.... little sex never killed nobody :p girl is creative, that’s all xD", likesCount: "0 like", time: "6 hours ago", replies: []),
            Comment(username: "msvitton", userIMG: "https://shorturl.at/fwzY6", commentText: "Do you agree that in this book was a little to much of an obscene conversations?", likesCount: "100k likes", time: "8 hours ago", replies: [])
        ])
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                AboutBook()
                
                HStack(spacing: 8){
                    Button {
                        
                    } label: {
                        CustomOutlineButton(title: "Status", foregroundTextColor: .customPink, outlineColor: .customPink)
                    }
                    Button {
                        
                    } label: {
                        CustomButton(title: "Add", foreground: .white, background: .customPink)
                    }
                }
                
                HStack(spacing: 16){
                    InfoView(count: 145, title: "Collections")
                    InfoView(count: 58, title: "Likes")
                    InfoView(count: 5786, title: "Comments")
                }
                
                DescriptionView()
                
                BookTags()
                
                Comments()
            }
            .padding()
        }
        .padding(.bottom, 55)
        .overlay(
            commentInputField()
            , alignment: .bottom
        )
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("I'm fine neither are you")
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
            ToolbarItem {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(Angle(degrees: 90))
                        .foregroundColor(.customBlack)
                }
            }
        }
    }
    
    @ViewBuilder func AboutBook() -> some View {
        VStack {
            TabView(selection: $index) {
                VStack {
                    WebImageView(url: URL(string: "https://shorturl.at/qsz08"), defaultImage: "photo")
                        .frame(width: 160, height: 248)
                        .cornerRadius(12)
                        .overlay (
                            Button{
                                
                            } label: {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 32, height: 32)
                                    .padding(12)
                                    .shadow(color: .black.opacity(0.1), radius: 4, y: 4)
                                    .overlay(
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.lightGrey)
                                    )
                            }
                            ,alignment: .bottomTrailing
                        )
                    Spacer()
                }
                .tag(0)
                
                VStack {
                    WebImageView(url: URL(string: "https://shorturl.at/qsz08"), defaultImage: "photo")
                        .frame(width: 160, height: 248)
                        .cornerRadius(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.6))
                                .overlay (
                                    VStack(spacing: 16) {
                                        Text("Amazon Publishing 2019")
                                        
                                        Text("Paperback  227 pages")
                                    }
                                        .font(.robotoBold(size: 16))
                                        .shadow(color: Color.black.opacity(0.3), radius: 4, y: 4)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                        .padding(.top, 24)
                                        .padding(10)
                                    , alignment: .top
                                )
                                .overlay(
                                    Text("ISBN: 8308849310")
                                        .font(.robotoBold(size: 16))
                                        .shadow(color: Color.black.opacity(0.3), radius: 4, y: 4)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 12)
                                    , alignment: .bottom
                                )
                        }
                    Spacer()
                }
                .tag(1)
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.darkGrey)
                UIPageControl.appearance().pageIndicatorTintColor = UIColor(.backgroundGrey)
            }
            .padding(.bottom, -16)
            
            VStack(spacing: 8) {
                Text("I'm fine neither are you")
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
                Text("Camille Pagan")
                    .font(.system(size: 16))
                    .foregroundColor(.darkGrey)
            }
        }
    }
    
    func InfoView(count: Int, title: String) -> some View{
        VStack(spacing: 4){
            Text("\(count)")
                .font(.poppinsBold(size: 16))
            Text(title)
                .font(.poppinsMedium(size: 14))
                .foregroundColor(.darkGrey)
        }
    }
    
    @ViewBuilder func DescriptionView() -> some View {
        VStack(alignment: .leading, spacing: 11) {
            Text("Description")
                .foregroundColor(.customBlack)
                .font(.poppinsBold(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.")
                    .font(.system(size: 14))
                    .foregroundColor(.customBlack)
                    .lineLimit(isDescriptionExpanded ? nil : 5)
                    .padding(.top, 5)
                
                Button {
                    withAnimation() {
                        isDescriptionExpanded.toggle()
                    }
                } label: {
                    Text(isDescriptionExpanded ? "Read less..." : "Read more...")
                        .foregroundColor(.lightGrey)
                        .font(.system(size: 14, weight: .heavy))
                }
            }
        }
    }
    
    @ViewBuilder func BookTags() -> some View{
        VStack(spacing: 8) {
            Button {
                
            } label: {
                CollectionTitle(title: "Book tags")
            }
            
            (Text("#creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.accentColor)
            .multilineTextAlignment(.leading)
            
            HStack {
                Button {
                    
                } label: {
                    Text("Add tag")
                        .foregroundColor(.lightGrey)
                        .font(.system(size: 14, weight: .heavy))
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder func Comments() -> some View{
        VStack(spacing: 12) {
            HStack {
                Text("Comments")
                    .foregroundColor(.customBlack)
                    .font(.poppinsSemiBold(size: 20))
                Spacer()
                Text("(19)")
                    .font(.poppinsSemiBold(size: 14))
                    .foregroundColor(.darkGrey)
            }
            
            VStack{
                ForEach(comments) { comment in
                    CommentView(comment: comment)
                }
            }
        }
    }
    
    @ViewBuilder func commentInputField() -> some View{
        HStack(spacing: 8) {
            Button {
                
            } label: {
                
                Image("at-icon")
                    .frame(width: 24, height: 24)
                    .background(Color.accentColor.cornerRadius(12))
            }
            
            Button {
                
            } label: {
                Image("hash-icon")
                    .frame(width: 24, height: 24)
                    .background(Color.accentColor.cornerRadius(12))
            }
            
            TextField("Add comment...", text: $commentText)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
                .background(Color.containerGrey.cornerRadius(18)).overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.lightGrey, lineWidth: 1)
                )
                .padding(.vertical, 6)
            
            Button {
                
            } label: {
                Image(systemName: "arrow.right")
                    .foregroundColor(.lightGrey)
                    .font(.title)
            }
            .padding(.horizontal, 8)
            
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .padding(.horizontal)
        .background(Color.white)
        .overlay(
            Divider()
            , alignment: .top
        )
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailsView()
        }
    }
}
