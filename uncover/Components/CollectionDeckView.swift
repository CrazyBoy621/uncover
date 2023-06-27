//
//  BookDeckView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI

struct CollectionDeckView: View {
    
    let title: String
    let username: String
    let collectionUrl: String
    let userAvatarUrl: String
    let rating: Int
    
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
                            WebImageView(url: URL(string: userAvatarUrl))
                                .frame(width: 32, height: 32)
                                .cornerRadius(16)
                        )
                    Text(username)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Text("\(rating) \(rating > 1 ? "books".localized.lowercased() : "book".localized.lowercased())")
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
        .frame(width: (UIScreen.screenWidth - 32), height: (UIScreen.screenWidth - 32) / 335 * 420)
        .background(
            WebImageView(url: URL(string: collectionUrl))
                .aspectRatio(contentMode: .fill)
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.3), radius: 8, y: 4)
    }
}

struct CollectionDeckView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDeckView(title: "Re-read someday", username: "martinpalmer", collectionUrl: "https://shorturl.at/iMVZ7", userAvatarUrl: "https://shorturl.at/fwzAP", rating: 1)
    }
}
