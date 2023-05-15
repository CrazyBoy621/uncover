//
//  CustomLargeButton.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 15/05/23.
//

import SwiftUI

struct CustomLargeButton: View {
    let title: String
    let background: Color
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.poppinsSemiBold(size: 16))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(
                background.cornerRadius(10)
            )
    }
}

struct CustomLargeButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomLargeButton(title: "Explore", background: .accentColor)
    }
}
