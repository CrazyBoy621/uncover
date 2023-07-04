//
//  MyCurrentReadsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 01/07/23.
//

import SwiftUI

struct MyCurrentReadsView: View {
    var body: some View {
        ZStack {
            Image("my-current-reads-bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 56) {
                Image("text-background")
                    .overlay(
                        Text("My current read")
                            .font(.amithenRegular(size: 40))
                    )
                    .padding(.top, 56)
                
                Spacer()
                
                ZStack {
                    WebImageView(url: URL(string: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1528&q=80"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 147.49, height: 231.38)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 4, y: 4)
                    
                    Image("arrow")
                        .overlay(
                            Text("romance")
                                .frame(width: UIScreen.main.bounds.width - 50, alignment: .leading)
                                .font(.amithenRegular(size: 30))
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                                .foregroundColor(.customBlack)
                                .padding(.leading, -20)
                                .padding(.top, -30)
                            , alignment: .topLeading
                        )
                        .offset(x: -120, y: -150)
                    
                    Image("arrow")
                        .scaleEffect(x: -1, y: 1)
                        .overlay(
                            Text("spicy")
                                .frame(width: UIScreen.main.bounds.width - 50, alignment: .trailing)
                                .font(.amithenRegular(size: 30))
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                                .foregroundColor(.customBlack)
                                .padding(.trailing, -20)
                                .padding(.top, -30)
                            , alignment: .topTrailing
                        )
                        .offset(x: 110, y: -100)
                    
                    Image("arrow")
                        .scaleEffect(x: -1, y: 1)
                        .rotationEffect(Angle(degrees: 180))
                        .overlay(
                            Text("grumpyandsunsinetrope")
                                .frame(width: UIScreen.main.bounds.width - 50, alignment: .leading)
                                .font(.amithenRegular(size: 30))
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                                .foregroundColor(.customBlack)
                                .padding(.leading, -20)
                                .padding(.bottom, -30)
                            , alignment: .bottomLeading
                        )
                        .offset(x: -120, y: 150)
                    
                    Image("arrow")
                        .rotationEffect(Angle(degrees: 173))
                        .overlay(
                            Text("fakedating")
                                .frame(width: UIScreen.main.bounds.width - 50, alignment: .trailing)
                                .font(.amithenRegular(size: 30))
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                                .foregroundColor(.customBlack)
                                .padding(.trailing, -20)
                                .padding(.bottom, -30)
                            , alignment: .bottomTrailing
                        )
                        .offset(x: 110, y: 100)
                }
                .padding(.top, -56)
                
                Spacer()
            }
        }
    }
}

struct MyCurrentReadsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCurrentReadsView()
    }
}
