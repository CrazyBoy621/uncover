//
//  View+.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 04/06/23.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
