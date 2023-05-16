//
//  BookDetailsView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 17/05/23.
//

import SwiftUI

struct BookDetailsView: View {
    
    @State var isDescriptionExpanded = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        WebImageView(url: URL(string: "https://shorturl.at/qsz08"), defaultImage: "photo")
                            .frame(width: 160, height: 248)
                            .cornerRadius(12)
                            .overlay (
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 32, height: 32)
                                    .padding(12)
                                    .shadow(color: .black.opacity(0.1), radius: 4, y: 4)
                                    .overlay(
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.lightGrey)
                                    )
                                ,alignment: .bottomTrailing
                            )
                        
                        HStack(spacing: 8){
                            Circle()
                                .fill(Color.darkGrey)
                                .frame(width: 8, height: 8)
                            Circle()
                                .fill(Color.lightGrey)
                                .frame(width: 8, height: 8)
                        }
                        
                        VStack(spacing: 8) {
                            Text("I'm fine neither are you")
                                .font(.poppinsBold(size: 20))
                                .foregroundColor(.customBlack)
                            Text("Camille Pagan")
                                .font(.system(size: 16))
                                .foregroundColor(.darkGrey)
                        }
                    }
                    
                    HStack(spacing: 8){
                        Button {
                            
                        } label: {
                            CustomButton(title: "Status", foreground: .customPink, background: .white)
                                .padding(1)
                                .background(Color.customPink)
                                .cornerRadius(16)
                        }
                        Button {
                            
                        } label: {
                            CustomButton(title: "Add", foreground: .white, background: .customPink)
                        }
                    }
                    
                    HStack(spacing: 16){
                        InfoView(count: 145, title: "Collections")
                        InfoView(count: 58, title: "Likes")
                        InfoView(count: 5786, title: "Comments")
                    }
                    
                    DescriptionView()
                    
                    BookTags()
                    
                    Comments()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("I'm fine neither are you")
                        .font(.poppinsBold(size: 20))
                        .foregroundColor(.customBlack)
                }
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(Angle(degrees: 90))
                            .foregroundColor(.customBlack)
                    }
                }
            }
        }
    }
    
    func InfoView(count: Int, title: String) -> some View{
        VStack(spacing: 4){
            Text("\(count)")
                .font(.poppinsBold(size: 16))
            Text(title)
                .font(.poppinsMedium(size: 14))
                .foregroundColor(.darkGrey)
        }
    }
    
    @ViewBuilder func DescriptionView() -> some View {
        VStack(alignment: .leading, spacing: 11) {
            Text("Description")
                .foregroundColor(.customBlack)
                .font(.poppinsBold(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.Sometimes dead is better....When the Creeds move into a beautiful old house in rural Maine, it all seems too good to be true: physician father, beautiful wife, charming little daughter, adorable infant son -- and.")
                .font(.system(size: 14))
                .foregroundColor(.customBlack)
                .lineLimit(isDescriptionExpanded ? nil : 5)
                .padding(.top, 5)
            
            Button {
                withAnimation() {
                    isDescriptionExpanded.toggle()
                }
            } label: {
                Text(isDescriptionExpanded ? "Read less..." : "Read more...")
                    .foregroundColor(.lightGrey)
                    .font(.system(size: 14, weight: .heavy))
            }
        }
    }
    
    @ViewBuilder func BookTags() -> some View{
        VStack(spacing: 8) {
            Button {
                
            } label: {
                CollectionTitle(title: "Book tags")
            }
            
            (Text("#creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy")
             +
             Text(" #creepy"))
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.accentColor)
            .multilineTextAlignment(.leading)
            
            HStack {
                Button {
                    
                } label: {
                    Text("Add tag")
                        .foregroundColor(.lightGrey)
                        .font(.system(size: 14, weight: .heavy))
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder func Comments() -> some View{
        VStack(spacing: 12) {
            HStack {
                Text("Comments")
                    .foregroundColor(.customBlack)
                    .font(.poppinsSemiBold(size: 20))
                Spacer()
                Text("(19)")
                    .font(.poppinsSemiBold(size: 14))
                    .foregroundColor(.darkGrey)
            }
            
            HStack(spacing: 12){
                VStack {
                    WebImageView(url: URL(string: "https://shorturl.at/bfvFK"))
                        .frame(width: 40, height: 40)
                    .cornerRadius(20)
                    Spacer()
                }
                
                VStack(spacing: 4){
                    HStack{
                        Text("ninasmith")
                            .font(.robotoBold(size: 16))
                        Spacer()
                        Text("1 hour ago")
                            .font(.robotoRegular(size: 16))
                            .foregroundColor(.darkGrey)
                    }
                    
                    Text("Beautiful love story with the twist. You want expect the ending! One of the best book by this author. I really like her...")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.leading)
                    
//                    Button{
//
//                    } label: {
//                        Text("more")
//                            .font(.robotoMedium(size: 16))
//                            .foregroundColor(.accentColor)
//                    }
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Reply")
                                .font(.robotoMedium(size: 14))
                                .foregroundColor(.darkGrey)
                        }
                        
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 2, height: 2)
                        
                        Button {
                            
                        } label: {
                            Text("Like")
                                .font(.robotoMedium(size: 14))
                                .foregroundColor(.darkGrey)
                        }
                        
                        Circle()
                            .fill(Color.lightGrey)
                            .frame(width: 2, height: 2)
                        
                        Text("12 likes")
                            .font(.robotoRegular(size: 14))
                            .foregroundColor(.lightGrey)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView()
    }
}
