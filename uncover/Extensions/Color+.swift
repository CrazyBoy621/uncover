//
//  Color+.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 13/05/23.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
    static var navigationShadow = Color("navigationShadow")
    static var checkMarkColor = Color("checkMarkColor")
    static var customBlack = Color("customBlack")
    static var silver = Color("silver")
    static var lightBlue = Color("lightBlue")
    static var darkBlue = Color("darkBlue")
    static var softBlue = Color("softBlue")
    static var customGreen = Color("customGreen")
    static var customPink = Color("customPink")
    static var customRed = Color("customRed")
    static var customYellow = Color("customYellow")
    static var darkGrey = Color("darkGrey")
    static var dividerGrey = Color("dividerGrey")
    static var lightGrey = Color("lightGrey")
    static var lightPink = Color("lightPink")
    static var backgroundGrey = Color("backgroundGrey")
    static var containerGrey = Color("containerGrey")
    static var mainColor = Color("AccentColor")
}
