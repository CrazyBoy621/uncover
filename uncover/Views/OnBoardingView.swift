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
                    OnBoarding1()
                case .onboarding2:
                    OnBoarding2()
                case .onboarding3:
                    OnBoarding3()
                case .welcome:
                    Welcome()
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
    
    @ViewBuilder func OnBoarding1() -> some View{
        VStack {
            Image("onboarding-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay (
                    HStack{
                        Circle()
                            .fill(Color.darkGrey)
                            .frame(width: 6, height: 6)
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 6, height: 6)
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 6, height: 6)
                    }
                        .padding(.bottom, 36)
                    ,alignment: .bottom
                )
            VStack(spacing: 20) {
                Text("Discover")
                    .font(.poppinsRegular(size: 28))
                Text("Search by favourite subject, author, title, or maybe plot elements – mix and match!Tags will make it easy for you. Just dive in other’s ideas and discover new titles.")
                    .foregroundColor(.darkGrey)
                    .font(.poppinsRegular(size: 16))
                    .multilineTextAlignment(.center)
                Button {
                    currentOnBoard = .onboarding2
                } label: {
                    CustomLargeButton(title: "Continue", background: .accentColor)
                }
                .padding(.top, 12)
                
                Button {
                    currentOnBoard = .welcome
                } label: {
                    Text("Skip")
                        .foregroundColor(.darkGrey)
                        .font(.system(size: 16, weight: .semibold))
                }
                
                
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder func OnBoarding2() -> some View{
        VStack {
            Image("onboarding-2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay (
                    HStack{
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 6, height: 6)
                        Circle()
                            .fill(Color.darkGrey)
                            .frame(width: 6, height: 6)
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 6, height: 6)
                    }
                        .padding(.bottom, 36)
                    ,alignment: .bottom
                )
                .padding(.top, 15)
            VStack(spacing: 20) {
                Text("Create")
                    .font(.poppinsRegular(size: 28))
                Text("Create your own books ollections on any subject, writer or character’s key features. Show others your extraordinary taste in books and become a bookfluencer!")
                    .foregroundColor(.darkGrey)
                    .font(.poppinsRegular(size: 16))
                    .multilineTextAlignment(.center)
                Button {
                    currentOnBoard = .onboarding3
                } label: {
                    CustomLargeButton(title: "Continue", background: .accentColor)
                }
                .padding(.top, 12)
                
                Button {
                    currentOnBoard = .welcome
                } label: {
                    Text("Skip")
                        .foregroundColor(.darkGrey)
                        .font(.system(size: 16, weight: .semibold))
                }
                
                
            }
            .padding(.horizontal)
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder func OnBoarding3() -> some View{
        VStack {
            Image("onboarding-3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay (
                    HStack{
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 6, height: 6)
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 6, height: 6)
                        Circle()
                            .fill(Color.darkGrey)
                            .frame(width: 6, height: 6)
                    }
                        .padding(.bottom, 36)
                    ,alignment: .bottom
                )
            VStack(spacing: 20) {
                Text("Get inspired")
                    .font(.poppinsRegular(size: 28))
                Text("You can follow inspiring accounts or just individual collections. Save them, share them, get back to them. Discuss your reads with other members")
                    .foregroundColor(.darkGrey)
                    .font(.poppinsRegular(size: 16))
                    .multilineTextAlignment(.center)
                Button {
                    currentOnBoard = .welcome
                } label: {
                    CustomLargeButton(title: "Continue", background: .accentColor)
                }
                .padding(.top, 12)
                
                Button {
                    currentOnBoard = .welcome
                } label: {
                    Text("Skip")
                        .foregroundColor(.darkGrey)
                        .font(.system(size: 16, weight: .semibold))
                }
                
                
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder func Welcome() -> some View{
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
                    Button {
                        
                    } label: {
                        ContinueWith(imgName: "google", continueWith: "Google")
                    }
                    Button {
                        
                    } label: {
                        ContinueWith(imgName: "facebook", continueWith: "Facebook")
                    }
                    Button {
                        
                    } label: {
                        CustomLargeButton(title: "Continue with e-mail", background: .accentColor)
                    }
                    Button {
                        
                    } label: {
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
        OnBoardingView(currentOnBoard: .welcome)
    }
}
