//
//  CreateCollectionView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 03/06/23.
//

import SwiftUI

struct CreateCollectionView: View {
    
    @State var collectionName = ""
    @State var showChangeBackground = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        CollectionCard(collectionName: $collectionName) {
                            withAnimation {
                                showChangeBackground = true
                            }
                        }
                    }
                    .padding(.top, 25)
                    .padding(.bottom, 32)
                    .padding(.horizontal, 20)
                }
                
                if collectionName.count == 0 {
                    VStack {
                        Spacer()
                        ErrorWarning()
                            .padding(.bottom, 32)
                            .padding(.horizontal, 24)
                    }
                }
                
                ChangeBackground()
                    .offset(y: showChangeBackground ? 0 : 1000)
                    .transition(.move(edge: .bottom))
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("x-mark")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Create Collection")
                        .font(.poppinsBold(size: 20))
                        .foregroundColor(.customBlack)
                }
                ToolbarItem {
                    NavigationLink {
                        AddBooksToCollectionView()
                    } label: {
                        Text("Next")
                            .font(.poppinsSemiBold(size: 16))
                    }
                    
                }
            }
        }
    }
}

struct CollectionCard: View {
    
    @Binding var collectionName:String
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            WebImageView(url: URL(string: "https://s3-alpha-sig.figma.com/img/f1af/8c51/36b8551759e45851870011c50b4d66e8?Expires=1686528000&Signature=qDEHfKItHdu~VMcR-Nl52~J0HSCdXW1SJb4dCTuEh3ZlBC5FV-MlaXI4uOkW8O-zWR8FcLCtBm~BtvIqaqYTF-7I6zzsjYb17-XuEyutbuJkjBjOf4-UtDmxAsdWxr9BkRoDN-WqSl2R-UlOb~5njD~xrsh7h6VtVy-labjPp1fctiRgaIsonrBAErb6QFxp4qMF4dMgnvkRubrISizbEUI5zFyw46wiGaxcxdPUo7qIMiUV12Qg3nobJa5iaMaplkQO3AiUZjfPFmXJPWfYlC9arM9AtQ2h2DimDXHVW7qmuHhT8vBFM~2y3-83uSVs8rEmzXR--roy-Bx6vYvp6A__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"))
                .frame(height: 420)
                .scaledToFill()
            
            VStack {
                OpacityRectangle(height: 135)
                Spacer()
                OpacityRectangle(height: 70)
                    .rotationEffect(Angle(degrees: 180))
            }
            
            VStack {
                TextEditorView(string: $collectionName, placeholder: "Write a title of your collection")
                    .font(.poppinsBold(size: 28))
                    .foregroundColor(.white)
                    .shadow(color: Color.white.opacity(0.3), radius: 4, x: 0, y: 4)
                Spacer()
                Button {
                    completion()
                } label: {
                    HStack(spacing: 16) {
                        Image("empty-image")
                        Text("Change background")
                            .font(.poppinsSemiBold(size: 16))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        VisualEffectView(effect: UIBlurEffect(style: .light))
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(14)
                    )
                }

            }
            .padding(24)
        }
        .cornerRadius(12)
        .frame(height: 420)
        .shadow(
            color: Color.black.opacity(0.3), radius: 4, x: 0,  y: 4
        )
    }
    
    @ViewBuilder func OpacityRectangle(height: CGFloat) -> some View{
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.3),
                        Color.black.opacity(0)
                    ],
                    startPoint: .top, endPoint: .bottom
                )
            )
            .frame(height: height)
    }
}

struct ErrorWarning: View {
    var body: some View {
        HStack {
            Text("Please name your collection")
                .font(.poppinsSemiBold(size: 16))
                .foregroundColor(.customPink)
            Spacer()
            Image("exclamation-mark")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.lightPink)
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
        )
    }
}

struct ChangeBackground: View {
    
    @State var searchValue = ""
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Change background")
                .font(.poppinsBold(size: 20))
                .foregroundColor(.customBlack)
                .frame(maxWidth: .infinity)
            
            HStack {
                Image("search")
                TextField("Search", text: $searchValue)
                Button {
                    
                } label: {
                    Image("camera")
                }
            }
            .padding()
            .background(Color.containerGrey.cornerRadius(14))
        }
        .padding(.horizontal)
        .padding(.top, 32)
        .background(Color.white)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct CreateCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeBackground()
    }
}
