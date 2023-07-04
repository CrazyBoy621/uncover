//
//  UserCollectionsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 05/07/23.
//

import SwiftUI

struct UserCollectionsView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Controller("arrow.up.arrow.down", "Sort")
                    Controller("square.grid.2x2.fill", "View")
                }
                .padding(.trailing, 20)
                
                LazyVGrid(columns:
                            [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 24) {
                                ForEach(1...20, id: \.self) { index in
                                    CollectionCard()
                                }
                            }
                            .padding(.horizontal, 16)
            }
            .padding(.vertical, 20)
        }
        .navigationTitle("collections".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("collections".localized)
                    .font(.poppinsExtraBold(size: 20))
            }
        }
    }
    
    @ViewBuilder func Controller(_ iconName: String, _ title: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 16, height: 16)
            
            Text(title)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 16)
        .foregroundColor(.customBlack)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke()
        )
    }
    
    @ViewBuilder func CollectionCard() -> some View{
        ZStack(alignment: .top) {
            Image("background-img")
                .resizable()
                .frame(width: ((UIScreen.screenWidth / 2) - 32), height: ((UIScreen.screenWidth / 2) - 32) / 167 * 206)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(12)
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
}

struct UserCollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserCollectionsView()
        }
    }
}
