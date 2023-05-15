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
                ZStack {
                    VStack {
                        Image("empty-background")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.all)
                        Spacer()
                    }
                }
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
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
