//
//  SearchTextField.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 21/05/23.
//

import SwiftUI

struct SearchTextField: View {
    
let placeholder: String
let text: Binding<String>
    
    var body: some View {
        TextField(placeholder, text: text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 50)
            .frame(height: 55)
            .background(Color.containerGrey.cornerRadius(14))
            .overlay(
                Image(systemName: "magnifyingglass")
                    .padding(.horizontal, 12)
                    .font(.title2)
                    .foregroundColor(.darkGrey)
                , alignment: .leading
            )
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(placeholder: "Text", text: .constant(""))
    }
}
