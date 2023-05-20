//
//  OnBoardingView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI

struct Onboarding: Identifiable {
    var id = UUID()
    let image: String
    let title: String
    let subtitle: String
}

struct OnboardingView: View {
    
    private var onboardings = [
        Onboarding(
            image: "onboarding-1",
            title: "Discover",
            subtitle: "Search by favourite subject, author, title, or maybe plot elements – mix and match! Tags will make it easy for you. Just dive in other’s ideas and discover new titles."
        ),
        Onboarding(
            image: "onboarding-2",
            title: "Book Collections",
            subtitle: "Organize your reads. Save all your books on your bookish profile divided into your own categories. Be creative without any limits!"
        ),
        Onboarding(
            image: "onboarding-3",
            title: "Recommendations",
            subtitle: "Join a bookish community to stay up to date with book trends. Discuss your reads with other members and discover new books on a social feed!"
        )
    ]
    
    @State var reloadAnimation = true
    @State var index = 0
    @AppStorage("onboarding") var onboarding: Bool = true
    
    var body: some View {
        VStack {
            TabView(selection: $index) {
                ForEach(Array(onboardings.enumerated()), id: \.offset) { index, onboarding in
                    CardView(image: onboarding.image, title: onboarding.title, subtitle: onboarding.subtitle)
                }
            }
            .tabViewStyle(.page)
            
            Spacer()
            
            Button {
                withAnimation {
                    if index == onboardings.count - 1 {
                        onboarding = false
                    } else {
                        index += 1
                    }
                }
            } label: {
                CustomLargeButton(title: "Continue", foreground: .white, background: .accentColor)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Button {
                onboarding = false
            } label: {
                Text("Skip")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 16, weight: .semibold))
            }
        }
        .navigationTitle("uncover")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("uncover-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    @ViewBuilder func CardView(image: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 16) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
            VStack(spacing: 16) {
                Text(title)
                    .font(.poppinsRegular(size: 28))
                
                Text(subtitle)
                    .foregroundColor(.darkGrey)
                    .font(.poppinsRegular(size: 16))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
        }
        .offset(y: -60)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OnboardingView()
        }
    }
}
