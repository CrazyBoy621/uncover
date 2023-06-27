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
            title: "discover".localized,
            subtitle: "onboarding_1_description".localized
        ),
        Onboarding(
            image: "onboarding-2",
            title: "book_collections".localized,
            subtitle: "onboarding_2_description".localized
        ),
        Onboarding(
            image: "onboarding-3",
            title: "recommendations".localized,
            subtitle: "onboarding_3_description".localized
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
                CustomLargeButton(title: "continue".localized, foreground: .white, background: .mainColor)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Button {
                onboarding = false
            } label: {
                Text("skip".localized)
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
