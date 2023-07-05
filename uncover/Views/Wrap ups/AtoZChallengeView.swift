//
//  AtoZChallengeView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 03/07/23.
//

import SwiftUI

struct AtoZChallengeView: View {
    
    let books: [Book] = [
        Book(letter: "A", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "B", imageUrl: ""),
        Book(letter: "C", imageUrl: ""),
        Book(letter: "D", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "E", imageUrl: ""),
        Book(letter: "F", imageUrl: ""),
        Book(letter: "G", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "H", imageUrl: ""),
        Book(letter: "I", imageUrl: ""),
        Book(letter: "J", imageUrl: ""),
        Book(letter: "K", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "L", imageUrl: ""),
        Book(letter: "M", imageUrl: ""),
        Book(letter: "N", imageUrl: ""),
        Book(letter: "O", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "P", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "Q", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "R", imageUrl: ""),
        Book(letter: "S", imageUrl: ""),
        Book(letter: "T", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "U", imageUrl: ""),
        Book(letter: "V", imageUrl: ""),
        Book(letter: "W", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        Book(letter: "X", imageUrl: ""),
        Book(letter: "Y", imageUrl: ""),
        Book(letter: "Z", imageUrl: "")
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Image("a-to-z-challenge-bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    Text("a_to_z_challenge".localized)
                        .font(.amithenRegular(size: 34))
                        .multilineTextAlignment(.center)
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(books, id: \.self) { book in
                            bookCard(letter: book.letter, imageUrl: book.imageUrl)
                        }
                    }
                    .padding()
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .background(
                    Image("a-to-z-challenge")
                        .padding(.trailing, 40)
                    , alignment: .bottomTrailing
                )
                .padding(.vertical, 32)
            }
        }
    }
}

struct Book: Hashable, Identifiable {
    let id = UUID()
    let letter: String
    let imageUrl: String
}

struct bookCard: View {
    
    let letter: String
    let imageUrl: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .frame(width: 57.14, height: 91.21)
                .shadow(color: Color(hex: "4737FF").opacity(0.08), radius: 25, x: 4, y: 12)
                .overlay(
                    Text(letter)
                        .font(.amithenRegular(size: 34))
                )
            
            if !imageUrl.isEmpty {
                WebImageView(url: URL(string: imageUrl))
                    .cornerRadius(8)
                    .frame(width: 57.14, height: 91.21)
                    .shadow(color: Color(hex: "4737FF").opacity(0.08), radius: 25, x: 4, y: 12)
            }
        }
    }
}

struct AtoZChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        AtoZChallengeView()
    }
}
