//
//  UnderConstructionView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI

struct UnderConstructionView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("empty-background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Image("under-contruction")
            }
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 11) {
                Text(("Under Contruction").uppercased())
                    .font(.poppinsRegular(size: 28))
                    .foregroundColor(.customBlack)
                Text("We’re doing necessery system updates. It may take a while. Sound like a great time to read a book instead!")
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
    }
}

struct UnderConstructionView_Previews: PreviewProvider {
    static var previews: some View {
        UnderConstructionView()
    }
}
