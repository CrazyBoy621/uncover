//
//  Font+.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 15/05/23.
//

import SwiftUI

extension Font {
    static func poppinsRegular(size: CGFloat) -> Font {
        return Font.custom("Poppins-Regular", size: size)
    }
    static func poppinsSemiBold(size: CGFloat) -> Font {
        return Font.custom("Poppins-SemiBold", size: size)
    }
    static func poppinsBold(size: CGFloat) -> Font {
        return Font.custom("Poppins-Bold", size: size)
    }
    static func poppinsMedium(size: CGFloat) -> Font {
        return Font.custom("Poppins-Medium", size: size)
    }
    static func poppinsExtraBold(size: CGFloat) -> Font {
        return Font.custom("Poppins-ExtraBold", size: size)
    }
    static func robotoMedium(size: CGFloat) -> Font {
        return Font.custom("Roboto-Medium", size: size)
    }
    static func robotoBold(size: CGFloat) -> Font {
        return Font.custom("Roboto-Bold", size: size)
    }
    static func robotoRegular(size: CGFloat) -> Font {
        return Font.custom("Roboto-Regular", size: size)
    }
    static func amithenRegular(size: CGFloat) -> Font {
        return Font.custom("amithen", size: size)
    }
}
