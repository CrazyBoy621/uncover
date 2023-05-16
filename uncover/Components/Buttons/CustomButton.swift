//
//  CustomButton.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/05/23.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let foreground: Color
    let background: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(background)
            .frame(width: 120, height: 32)
            .overlay(
                Text(title)
                    .font(.poppinsSemiBold(size: 16))
                    .foregroundColor(foreground)
            )
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Edit", foreground: .white, background: .customPink)
    }
}
