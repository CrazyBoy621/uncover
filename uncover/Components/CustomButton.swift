//
//  CustomButton.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/05/23.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let background: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .background(
                Rectangle()
                    .fill(background)
                    .cornerRadius(16)
                    .frame(width: 120, height: 32)
            )
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Edit", background: .customPink)
    }
}
