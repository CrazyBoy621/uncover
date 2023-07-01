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
                Spacer()
                
                ZStack {
                    WebImageView(url: URL(string: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1528&q=80"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 147.49, height: 231.38)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 4, y: 4)
                    
                    VStack {
                        Text("romanfce")
                            .frame(width: 200)
                            .font(.amithenRegular(size: 30))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            .foregroundColor(.customBlack)
                        Image("arrow")
                    }
                    .offset(x: -120, y: -150)
                }
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
