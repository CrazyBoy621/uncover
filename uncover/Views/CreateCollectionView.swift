//
//  CreateCollectionView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 03/06/23.
//

import SwiftUI

struct CreateCollectionView: View {
    
    let publisher = NotificationCenter.default.publisher(for: Notification.Name("dismissPublishingCollectionsView"))
    
    @State var collectionName = ""
    @State var collectionInputFocused = true
    @State var showChangeBackground = false
    @State var offsetChangeBackground = 1000
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
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
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(publisher, perform: { output in
                    presentationMode.wrappedValue.dismiss()
                })
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
                        Text("create_collection".localized)
                            .font(.poppinsBold(size: 20))
                            .foregroundColor(.customBlack)
                    }
                    ToolbarItem {
                        NavigationLink {
                            AddBooksToCollectionView()
                        } label: {
                            Text("next".localized)
                                .font(.poppinsSemiBold(size: 16))
                        }
                        
                    }
                }
            }
            .accentColor(.mainColor)
            
            ZStack {
                Color.black.opacity(showChangeBackground ? 0.2 : 0)
                    .edgesIgnoringSafeArea(.all)
                ChangeBackgroundView()
                    .offset(y: CGFloat(offsetChangeBackground))
                    .transition(.move(edge: .bottom))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    offsetChangeBackground = Int(value.translation.height)
                                }
                            }
                            .onEnded { value in
                                withAnimation {
                                    if value.translation.height > 400 {
                                        offsetChangeBackground = 1000
                                        showChangeBackground = false
                                    } else {
                                        offsetChangeBackground = 0
                                    }
                                }
                            }
                    )
            }
        }
        .onChange(of: showChangeBackground) { newValue in
            hideKeyboard()
            withAnimation {
                offsetChangeBackground = newValue ? 0 : 1000
            }
        }
    }
}

struct CollectionCard: View {
    
    @Binding var collectionName:String
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            WebImageView(url: URL(string: "https://images.unsplash.com/photo-1580537659466-0a9bfa916a54?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"))
                .opacity(0.9)
                .frame(width: (UIScreen.screenWidth - 32), height: (UIScreen.screenWidth - 32) / 335 * 420)
                .scaledToFill()
            
            VStack {
                OpacityRectangle(height: 135)
                Spacer()
                OpacityRectangle(height: 70)
                    .rotationEffect(Angle(degrees: 180))
            }
            
            VStack {
                TextEditorView(string: $collectionName, placeholder: "write_a_title_of_collection".localized)
                    .font(.poppinsBold(size: 28))
                    .foregroundColor(.white)
                    .shadow(color: Color.white.opacity(0.3), radius: 4, x: 0, y: 4)
                Spacer()
                Button {
                    completion()
                } label: {
                    HStack(spacing: 16) {
                        Image("empty-image")
                        Text("change_background".localized)
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
        .frame(width: (UIScreen.screenWidth - 32), height: (UIScreen.screenWidth - 32) / 335 * 420)
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
            Text("name_your_collection_alert".localized)
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

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct CreateCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCollectionView()
    }
}
