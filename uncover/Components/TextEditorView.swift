//
//  TextEditorView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 10/05/23.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding var string: String
    var placeholder: String
    @State var textEditorHeight: CGFloat = 40
    
    var body: some View {
        ZStack(alignment: .top) {
            Text(string)
                .foregroundColor(.clear)
                .background(
                    GeometryReader {
                        Color.clear.preference(
                            key: ViewHeightKey.self,
                            value: $0.frame(in: .local).size.height + 4
                        )
                    }
                )
            if string.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
            }
            if #available(iOS 16.0, *) {
                TextEditor(text: $string)
                    .frame(height: max(120, textEditorHeight))
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
            } else {
                TextEditor(text: $string)
                    .frame(height: max(120, textEditorHeight))
            }
        }
        .onPreferenceChange(ViewHeightKey.self) {
            textEditorHeight = $0 + 16
        }
        .padding(8)
    }
}


struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
