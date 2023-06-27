//
//  ConratulationsPupUpView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 27/06/23.
//

import SwiftUI

struct ConratulationsPupUpView: View {
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 20) {
                Text("Conratulations")
                    .font(.poppinsRegular(size: 28))
                    .foregroundColor(.customBlack)
                Text("You’ve accomplished to finish your yearly A-Z Challenge for 2022 by reading books for every letter of alphabet! ✨")
                    .multilineTextAlignment(.center)
                    .font(.poppinsRegular(size: 16))
                    .foregroundColor(.darkGrey)
            }
            
            Button {
                
            } label: {
                Text("Go to your wrap-up")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.poppinsSemiBold(size: 16))
                    .background(
                        Color.darkBlue.cornerRadius(10)
                    )
                    .padding(.horizontal, 32)
            }
            .shadow(color: Color.black.opacity(0.05), radius: 20, y: 10)
        }
        .padding(.horizontal)
        .padding(.bottom, 54)
        .padding(.top, 96)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.25), radius: 20, y: -3)
        .overlay(
            Image("badge")
                .overlay(
                    LottieView(name: "trophy_animation", isLoop: true)
                        .frame(width: 80, height: 80)
                )
                .padding(.top, -80)
            , alignment: .top
        )
    }
}

struct ConratulationsPupUpView_Previews: PreviewProvider {
    static var previews: some View {
        ConratulationsPupUpView()
    }
}
