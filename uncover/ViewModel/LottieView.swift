//
//  LottieView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 23/06/23.
//

import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewControllerRepresentable {
    
    var name: String
    var isLoop: Bool = true
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = isLoop ? .loop : .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        viewController.view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
