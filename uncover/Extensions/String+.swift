//
//  String+.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 27/06/23.
//

import Foundation

extension String {
    var localized: String {
            let language = Util.shared.appLanguage
            var bundle = Bundle.main
            if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
                bundle = Bundle(path: path) ?? Bundle.main
            } else if let path = Bundle.main.path(forResource: "en", ofType: "lproj") {
                bundle = Bundle(path: path) ?? Bundle.main
            }
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
}
