//
//  NotificationView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 15/05/23.
//

import SwiftUI

struct NotificationView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        Image("empty-background")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.all)
                        Image("empty-notification")
                    }
                    
                    VStack(spacing: 11) {
                        Text("It's lonely here")
                            .font(.poppinsRegular(size: 28))
                        
                        VStack {
                            Text("There is nothing here, yet :(")
                            Text("Let’s find you some interesting collections to follow!")
                        }
                        .foregroundColor(.darkGrey)
                        .multilineTextAlignment(.center)
                        .font(.poppinsRegular(size: 16))
                    }
                    .padding(.horizontal, 16)
                    
                    Button {
                        
                    } label: {
                        CustomLargeButton(title: "Explore", background: .accentColor)
                            .padding(24)
                    }
                }
                .padding(.bottom, 106)
            }
            .offset(y: -100)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Notification")
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
