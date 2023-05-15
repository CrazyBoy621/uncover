//
//  CollectionView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/05/23.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        VStack(spacing: 16){
            Button {
                
            } label: {
                CollectionTitle(title: "Collections")
            }
           
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(0..<20, content: { index in
                        CollectionCard()
                    })
                }
                .padding(.bottom, 18)
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
        .shadow(color: .black.opacity(0.15), radius: 18, y: 14)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
