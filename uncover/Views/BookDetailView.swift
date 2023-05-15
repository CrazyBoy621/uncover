//
//  BookDetailView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI

struct BookDetailView: View {
    
    @State var authorName = "paulwalker"
    @State var authorPhoto = "user-avatar"
    @State var readCount = 2
    @State var totalReadCount = 8
    @State var bookTitle = "Stories that would make you feel the speed of light"
    @State var bookDescription = "My favourite books when the ground frozes. Best with cup of hot coco! My favourite books when the ground frozes. Best with cup of hot coco! M My favourite books when the ground frozes. Best with cup of hot coco! y favourite books when the ground frozes. Best with cup of hot coco! My favourite books when the ground frozes. Best with cup of hot coco! My favourite books when the ground frozes. Best with cup of hot coco! Bilbo bagins ikjhmm,poyy"
    @State var commentCount = "5786"
    @State var likeCount = "89"
    @State var followerCount = "57,7K"
    @State var isFollowed = false
    
    var body: some View {
        ZStack {
            TopPhotoView()
            
            ScrollView {
                Spacer()
                    .frame(height: 150)
                VStack{
                    DetailContentView()
                    
                    BooksCollection()
                        .background(Color.white.cornerRadius(50))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.silver.cornerRadius(50))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 32, height: 32)
                                    .shadow(
                                        color: .black.opacity(0.1),
                                        radius: 4, y: 4
                                    )
                            )
                            .padding(8)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(Angle(degrees: 90))
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 32, height: 32)
                                    .shadow(
                                        color: .black.opacity(0.1),
                                        radius: 4, y: 4
                                    )
                            )
                            .padding(8)
                    }
                }
                .font(.system(size: 12))
                .foregroundColor(Color(UIColor.lightGray))
            }
        }
    }
    
    @ViewBuilder func TopPhotoView() -> some View{
        VStack {
            Image("background-img")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 400)
                .background(Color.blue)
                .clipped()
                .overlay(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0),
                                    Color.white
                                ]),
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(height: 200)
                    ,alignment: .bottom
                )
                .edgesIgnoringSafeArea(.top)
            Spacer()
        }
    }
    
    @ViewBuilder func DetailContentView() -> some View{
        VStack(spacing: 16){
            HStack{
                HStack(spacing: 16) {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Image(authorPhoto)
                                .resizable()
                        )
                    Text(authorName)
                        .font(.system(size: 14, weight: .semibold))
                }
                Spacer()
                HStack(spacing: 6) {
                    Image(systemName: "checkmark.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(Color.checkMarkColor)
                    Text("\(readCount) of \(totalReadCount) read")
                }
            }
            
            Text(bookTitle)
                .foregroundColor(.customBlack)
                .font(.system(size: 24, weight: .bold))
                .lineSpacing(5)
            
            Text(bookDescription)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.customBlack)
            
            HStack(spacing: 16) {
                BookDetailInfo(title: "5786", subTitle: "Comments")
                BookDetailInfo(title: "89", subTitle: "Likes")
                BookDetailInfo(title: "57,7K", subTitle: "Followers")
            }
            .padding(8)
            
            Button {
                isFollowed.toggle()
            } label: {
                CustomButton(title: "Follow", background: .accentColor)
                    .padding(.top, 8)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 32)
    }
    
    @ViewBuilder func BookDetailInfo(title: String, subTitle: String) -> some View{
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
            Text(subTitle)
                .font(.system(size: 14, weight: .medium))
        }
        .foregroundColor(.customBlack)
    }
    
    @ViewBuilder func BooksCollection() -> some View{
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 30),
                GridItem(.flexible(), spacing: 30)
            ], spacing: 16) {
                ForEach(0..<20) { index in
                    BookViewCard(title: "milk and honey", author: "Rupi Kaur", isRead: true)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)
    }
    
    @ViewBuilder func BookViewCard(title: String, author: String, isRead: Bool) -> some View{
        ZStack(alignment: .topTrailing ){
            VStack(spacing: 16) {
                Image("background-img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(16)
                VStack(spacing: 4) {
                    Text(title)
                        .bold()
                    Text(author)
                }
            }
            if isRead{
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.checkMarkColor)
                    .background(
                        Circle()
                            .fill(Color.white)
                    )
                    .frame(width: 24, height: 24)
                    .padding(10)
            }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
