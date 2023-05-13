//
//  NavigationView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/05/23.
//

import SwiftUI

enum Tabs {
    case home
    case search
    case plus
    case notification
    case profile
}

struct TabBarView: View {
    
    @Binding var currentTab: Tabs
    
    var body: some View {
        HStack(spacing: 0){
            Spacer()
            HStack{
                Button {
                    currentTab = .home
                } label: {
                    Image(currentTab == .home ? "home-selected" : "home")
                }
                Spacer()
                Button {
                    currentTab = .search
                } label: {
                    Image(currentTab == .search ? "search-selected" : "search")
                }
                Spacer()
                Button {
                    currentTab = .plus
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 50, height: 50)
                        )
                }
                Spacer()
                Button {
                    currentTab = .notification
                } label: {
                    Image(currentTab == .notification ? "notification-selected" : "notification")
                }
                
                Spacer()
                Button {
                    currentTab = .profile
                } label: {
                    Image(currentTab == .profile ? "user-selected" : "user")
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 74)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .navigationShadow, radius: 13, x: -3, y: 7)
        .padding(.horizontal, 30)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(currentTab: .constant(.home))
    }
}
