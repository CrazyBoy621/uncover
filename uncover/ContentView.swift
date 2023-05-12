//
//  ContentView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 12/05/23.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab: Tabs = .home
    var body: some View {
        ZStack{
            switch currentTab {
            case .home:
                HomeView()
            case .search:
                Text("Search")
            case .plus:
                Text("Plus")
            case .notification:
                Text("Notif")
            case .profile:
                Text("Profile")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            NavigationView(currentTab: $currentTab)
                .padding(.bottom)
            ,alignment: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
