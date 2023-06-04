//
//  ChangeBackgroundView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 04/06/23.
//

import SwiftUI

struct ChangeBackgroundView: View {
    
    @State var searchValue = ""
    @State var showCamera = false
    
    var body: some View {
        VStack {
            VStack(spacing: 32) {
                Text("Change background")
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
                    .frame(maxWidth: .infinity)
                
                if showCamera {
                    CameraView()
                        .transition(.move(edge: .trailing))
                    Spacer()
                } else {
                    SearchView()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 32)
            .background(Color.white)
            .clipShape(
                RoundedCornerShape(cornerRadius: 50, corners: [.topLeft, .topRight])
            )
            .overlay (
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.gray)
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)
                , alignment: .top
            )
        }
        .padding(.top, 48)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder func BookCard(imgUrl: String) -> some View {
        WebImageView(url: URL(string: imgUrl))
            .frame(width: 107, height: 134)
            .aspectRatio(contentMode: .fill)
            .cornerRadius(14)
    }
    
    @ViewBuilder func SearchView() -> some View {
        VStack(spacing: 16) {
            HStack {
                Image("search")
                TextField("Search", text: $searchValue)
                Button {
                    withAnimation {
                        showCamera = true
                    }
                } label: {
                    Image("camera")
                }
            }
            .padding()
            .background(Color.containerGrey.cornerRadius(14))
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns:
                            [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 10) {
                                ForEach(1...20, id: \.self) { index in
                                    BookCard(imgUrl: "https://s3-alpha-sig.figma.com/img/c460/2d86/d20ca040e5d10d05a84a97f0f083e217?Expires=1686528000&Signature=jl-CNaJrlIcoCOf6lHTs6nozAF-9nN6LPD5fn8hzkfC~L6yOLTVKs0OCzpeen5hUtYs~4HuxZHnzk5LSHqR2MF6gLWVYUUzJDjsRPeLZ7yeWSppqkmH2xY-8SRm1UgFHOaGyF4en7hP2Q02tgLWOkhBVpQdlQwfhGHyCIke1asEkmfFjHqitFgcNMmMjGpfmQqx9nKHeqWJhS1PwEVfspUEQYfaZfZhX8XaTUTd-K5RIa0pLt0wjbm4dxAsTBdpsHgiIZK8dBuz-0BE3JJq9KyHJQBygVxt~awd5krAab8INOBXrqxPy6uoHLCt6ZUQRpViN2YSHMuFByIAtZGVPhQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4")
                                }
                            }
            }
        }
    }
    
    @ViewBuilder func CameraView() -> some View {
        VStack(spacing: 40) {
            Image("empty-camera")
            VStack(spacing: 16) {
                Text("Camera access".uppercased())
                    .font(.poppinsRegular(size: 28))
                    .foregroundColor(.customBlack)
                Text("In order to upload photo as your collection background, please allow Uncover access to your camera.")
                    .multilineTextAlignment(.center)
                    .font(.poppinsRegular(size: 16))
                    .foregroundColor(.lightGrey)
            }
            Button {
                
            } label: {
                Text("Go to settings")
                    .font(.poppinsSemiBold(size: 16))
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 10)
                    )
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.vertical)
    }
}

struct RoundedCornerShape: Shape {
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}

struct ChangeBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeBackgroundView()
    }
}
