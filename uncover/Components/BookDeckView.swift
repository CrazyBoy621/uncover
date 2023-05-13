//
//  BookDeckView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI

struct BookDeckView: View {
    
    @State var title: String
    @State var username: String
    @State var rating: Int
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineSpacing(/*@START_MENU_TOKEN@*/42.0/*@END_MENU_TOKEN@*/)
                    .shadow(
                        color:Color.black.opacity(0.3),
                        radius: /*@START_MENU_TOKEN@*/4/*@END_MENU_TOKEN@*/,
                        x:0, y: 4
                    )
                Spacer()
                HStack(spacing: 10) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .aspectRatio(contentMode: .fit)
                        .overlay(
                            Image("user-avatar")
                        )
                    Text(username)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Text("\(rating) \(rating > 1 ? "books" : "book")")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(.white)
            }
            .padding(24)
            .background(
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color.black.opacity(0.3),
                                    Color.black.opacity(0)
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 135)
                , alignment: .top
            )
            .background(
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color.black.opacity(0.3),
                                    Color.black.opacity(0)
                                ]
                            ),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 70)
                , alignment: .bottom
            )
        }
        .frame(maxWidth: .infinity)
        .frame(height: 420)
        .background(
            Image("background-img")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.green)
        )
        .cornerRadius(16)
        .padding(.horizontal, 21)
    }
}

struct BookDeckView_Previews: PreviewProvider {
    static var previews: some View {
        BookDeckView(title: "Re-read someday", username: "martinpalmer", rating: 99)
    }
}
