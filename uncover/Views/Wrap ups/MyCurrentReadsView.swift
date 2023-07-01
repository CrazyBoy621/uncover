//
//  MyCurrentReadsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 01/07/23.
//

import SwiftUI

struct MyCurrentReadsView: View {
    var body: some View {
        ZStack {
            Image("my-current-reads-bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            Image("text-background")
            Text("My current read")
                .font(.amithenRegular(size: 18))
        }
    }
}

struct MyCurrentReadsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCurrentReadsView()
    }
}
