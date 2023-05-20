//
//  ContentView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTab: Tabs = .home
    
    var body: some View {
        NavigationView {
            ZStack{
                switch currentTab {
                case .home:
                    HomeView()
                case .search:
                    SearchView()
                case .plus:
                    Text("Plus")
                case .notification:
                    NotificationView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                TabBarView(currentTab: $currentTab)
                    .padding(.bottom)
                ,alignment: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
