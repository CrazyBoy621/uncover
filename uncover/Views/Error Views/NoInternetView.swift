//
//  NoInternet.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("empty-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
//                Image("no-internet")
                LottieView(name: "no_internet_animation", isLoop: true)
                    .frame(height: 300)
            }
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 11) {
                Text(("No Internet").uppercased())
                    .font(.poppinsRegular(size: 28))
                    .foregroundColor(.customBlack)
                Text("It seems like you don’t have a connection to the internet.")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 16))
                    .lineSpacing(6)
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    
                } label: {
                    CustomLargeButton(title: "Retry", foreground: .white, background: .mainColor)
                }
                .padding(.bottom, 36)
            }
            .padding(.horizontal, 24)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView()
    }
}
