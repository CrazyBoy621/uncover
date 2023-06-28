//
//  Util.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 27/06/23.
//

import Foundation
import SwiftUI

class Util {
    static let shared = Util()
    
    @AppStorage("appLanguage") var appLanguage: String = "en"
}
