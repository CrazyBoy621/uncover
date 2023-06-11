//
//  ContentView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 12/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var previousTab: Tabs = .home
    @State var currentTab: Tabs = .home
    
    @State var isUserCreatingCollection = false
    
    var body: some View {
        NavigationView {
            ZStack {
                switch currentTab {
                    case .home:
                        HomeView()
                    case .search:
                        SearchView()
                    case .plus:
                        Text("")
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
                , alignment: .bottom)
            .onChange(of: currentTab, perform: { newValue in
                if newValue == .plus {
                    isUserCreatingCollection = true
                    currentTab = previousTab
                }
                else {
                    previousTab = newValue
                }
            })
            .fullScreenCover(isPresented: $isUserCreatingCollection, content: {
                CreateCollectionView()
            })
        }
        .accentColor(.mainColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

