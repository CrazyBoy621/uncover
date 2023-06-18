//
//  SplashScreen.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 17/06/23.
//

import SwiftUI

struct SplashScreen: View {
    @State private var opacity: Double = 0
    @State private var backgroundOpacity: Double = 1

    var body: some View {
        ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                    .opacity(backgroundOpacity)
            
            Image("uncover-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 1.5)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) {
                        opacity = 1
                    }
                    withAnimation(.easeOut(duration: 0.5).delay(1.5)) {
                        opacity = 0
                        backgroundOpacity = 0
                    }
                }
        }
    }
}
