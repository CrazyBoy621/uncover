//
//  ContinueWith.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI

struct ContinueWith: View {
    let imgName: String
    let continueWith: String
    var body: some View {
        HStack(spacing: 24) {
            Image(imgName)
            Text("Continue with \(continueWith)")
                .foregroundColor(.customBlack)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.backgroundGrey, lineWidth: 1)
                .frame(maxWidth: .infinity)
        )
    }
}

struct ContinueWith_Previews: PreviewProvider {
    static var previews: some View {
        ContinueWith(imgName: "google", continueWith: "Google")
    }
}
