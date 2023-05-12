//
//  HomeView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 13/05/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home View")
        }
        .toolbar{
            ToolbarItem(placement: .principal) {
                Image("uncover-logo")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
