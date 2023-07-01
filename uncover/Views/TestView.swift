//
//  TestView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 01/07/23.
//

import SwiftUI

struct TestView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
