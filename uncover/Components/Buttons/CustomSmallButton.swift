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
        Text(title)
            .foregroundColor(foreground)
            .font(.system(size: 14, weight: .semibold))
            .frame(width: 80, height: 24)
            .background(background.cornerRadius(16))
    }
}

struct CustomSmallButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomSmallButton(title: "Following", foreground: .customPink, background: .lightPink)
    }
}
