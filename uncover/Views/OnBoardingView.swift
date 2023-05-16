//
//  OnBoardingView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 16/05/23.
//

import SwiftUI

enum OnboardingPages {
    case onboarding1
    case onboarding2
    case onboarding3
    case welcome
}

struct OnBoardingView: View {
    @State var currentOnBoard: OnboardingPages
    
    var body: some View {
        NavigationView {
            ScrollView {
                switch currentOnBoard {
                case .onboarding1:
                    OnboardingPage(imageName: "onboarding-1", title: "Discover", description: "Search by favourite subject, author, title, or maybe plot elements – mix and match! Tags will make it easy for you. Just dive in other’s ideas and discover new titles.", buttonText: "Continue", nextPage: .onboarding2) {
                        currentOnBoard = $0
                    }
                case .onboarding2:
                    OnboardingPage(imageName: "onboarding-2", title: "Create", description: "Create your own book collections on any subject, writer, or character’s key features. Show others your extraordinary taste in books and become a bookfluencer!", buttonText: "Continue", nextPage: .onboarding3) {
                        currentOnBoard = $0
                    }
                case .onboarding3:
                    OnboardingPage(imageName: "onboarding-3", title: "Get inspired", description: "You can follow inspiring accounts or just individual collections. Save them, share them, get back to them. Discuss your reads with other members.", buttonText: "Continue", nextPage: .welcome) {
                        currentOnBoard = $0
                    }
                case .welcome:
                    WelcomePage(currentOnBoard: $currentOnBoard)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("uncover-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct OnboardingPage: View {
    let imageName: String
    let title: String
    let description: String
    let buttonText: String
    let nextPage: OnboardingPages
    let action: (OnboardingPages) -> Void
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 15)
            VStack(spacing: 20) {
                Text(title)
                    .font(.poppinsRegular(size: 28))
                Text(description)
                    .foregroundColor(.darkGrey)
                    .font(.poppinsRegular(size: 16))
                    .multilineTextAlignment(.center)
                Button {
                    withAnimation {
                        action(nextPage)
                    }
                } label: {
                    CustomLargeButton(title: buttonText, foreground: .white, background: .accentColor)
                }
                .padding(.top, 12)
                
                Button {
                    action(.welcome)
                } label: {
                    Text("Skip")
                        .foregroundColor(.darkGrey)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct WelcomePage: View {
    @Binding var currentOnBoard: OnboardingPages
    
    var body: some View {
        VStack {
            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 36)
            
            VStack(spacing: 20) {
                VStack(spacing: 6) {
                    Text("Welcome")
                        .font(.poppinsSemiBold(size: 28))
                        .foregroundColor(.customBlack)
                    
                    Text("Enjoy sharing the books with others")
                        .foregroundColor(.darkGrey)
                        .font(.poppinsRegular(size: 16))
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    Button { } label: {
                        ContinueWith(imgName: "google", continueWith: "Google")
                    }
                    Button { } label: {
                        ContinueWith(imgName: "facebook", continueWith: "Facebook")
                    }
                    Button { } label: {
                        CustomLargeButton(title: "Continue with e-mail", foreground: .white, background: .accentColor)
                    }
                    Button { } label: {
                        Text("Explore as a guest")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.accentColor.opacity(0.8))
                    }
                }
                
                Text("Continuing to use Moodreaders means you accept our Terms of Service and Privacy Policy.")
                    .foregroundColor(.darkGrey)
                    .font(.system(size: 12, weight: .semibold))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .offset(y: -48)
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(currentOnBoard: .onboarding1)
    }
}
