//
//  BookDetailInfo.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import SwiftUI

struct BookDetailInfo: View {
    
    @State var title: String
    @State var subTitle: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
            Text(subTitle)
                .font(.system(size: 14, weight: .medium))
        }
        .foregroundColor(.customBlack)
    }
}

struct BookDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailInfo(title: "5786", subTitle: "Comments")
    }
}
