//
//  BookViewCard.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 14/05/23.
//

import SwiftUI

struct BookViewCard: View {
    
    @State var title: String
    @State var author: String
    @State var isRead: Bool
    
    var body: some View {
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

struct BookViewCard_Previews: PreviewProvider {
    static var previews: some View {
        BookViewCard(title: "milk and honey", author: "Rupi Kaur", isRead: true)
    }
}
