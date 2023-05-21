//
//  SearchingView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 21/05/23.
//

import SwiftUI

struct SearchingView: View {
    
    @State var searchValue = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                    SearchTextField(placeholder: "Search by title & author...", text: $searchValue)
            }
            .padding(16)
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView()
    }
}
