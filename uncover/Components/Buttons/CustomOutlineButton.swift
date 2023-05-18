//
//  CustomOutlineButton.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 17/05/23.
//

import SwiftUI

struct CustomOutlineButton: View {
    
    let title: String
    let foregroundTextColor: Color
    let outlineColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(outlineColor)
            .frame(width: 120, height: 32)
            .overlay {
                Text(title)
                    .foregroundColor(foregroundTextColor)
                    .font(.poppinsSemiBold(size: 16))
            }
    }
}

struct CustomOutlineButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomOutlineButton(title: "Status", foregroundTextColor: .customPink, outlineColor: .customPink)
    }
}
