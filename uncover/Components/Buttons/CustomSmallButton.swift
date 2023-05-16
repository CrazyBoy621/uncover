//
//  CustomSmallButton.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 15/05/23.
//

import SwiftUI

struct CustomSmallButton: View {
    
    let title: String
    let foreground: Color
    let background: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(background)
            .frame(width: 80, height: 24)
            .overlay(
                Text(title)
                    .font(.poppinsSemiBold(size: 14))
                    .foregroundColor(foreground)
            )
    }
}

struct CustomSmallButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomSmallButton(title: "Following", foreground: .customPink, background: .lightPink)
    }
}
