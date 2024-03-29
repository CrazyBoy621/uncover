//
//  CollectionTitle.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/05/23.
//

import SwiftUI

struct CollectionTitle: View {
    
    @State var title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundColor(.customBlack)
        .font(.poppinsBold(size: 20))
    }
}

struct CollectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        CollectionTitle(title: "Books")
    }
}
