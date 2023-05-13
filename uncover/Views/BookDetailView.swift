//
//  BookDetailView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI

struct BookDetailView: View {
    var body: some View {
        ZStack {
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
            ScrollView{
                DetailContent()
                    .padding(.top, 150)
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder func DetailContent() -> some View{
        VStack(spacing: 16){
            HStack{
                HStack(spacing: 16) {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 24, height: 24)
                    Text("paulwalker")
                        .font(.system(size: 14, weight: .semibold))
                }
                Spacer()
                HStack(spacing: 6){
                    Image(systemName: "checkmark.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(Color.checkMarkColor)
                    Text("2 of 8 read")
                }
            }
            
            Text("Stories that would make you feel the speed of light")
                .foregroundColor(.bookDetailTiextColor)
                .font(.system(size: 20, weight: .bold))
                .lineSpacing(5)
            
            Text("My favourite books when the ground frozes. Best with cup of hot coco! My favourite books when the ground frozes. Best with cup of hot coco! M My favourite books when the ground frozes. Best with cup of hot coco! y favourite books when the ground frozes. Best with cup of hot coco! My favourite books when the ground frozes. Best with cup of hot coco! My favourite books when the ground frozes. Best with cup of hot coco! Bilbo bagins ikjhmm,poyy")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.bookDetailTiextColor)
            
            HStack(spacing: 10){
                BookDetailInfo(title: "5786", subTitle: "Comments")
                BookDetailInfo(title: "89", subTitle: "Likes")
                BookDetailInfo(title: "57,7K", subTitle: "Followers")
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 32)
        .background(Color.white.cornerRadius(50))
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
