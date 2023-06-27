//
//  SomethingWentWrongView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI

struct SomethingWentWrongView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("empty-background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Image("went-wrong")
            }
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 11) {
                Text("oops".localized)
                    .font(.poppinsRegular(size: 28))
                .foregroundColor(.customBlack)
                Text("something_went_wrong".localized)
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    
                } label: {
                    CustomLargeButton(title: "back_to_home".localized, foreground: .white, background: .mainColor)
                }
                .padding(.bottom, 36)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SomethingWentWrongView_Previews: PreviewProvider {
    static var previews: some View {
        SomethingWentWrongView()
    }
}
