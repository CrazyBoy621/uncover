//
//  MonthReadsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 03/07/23.
//

import SwiftUI

struct MonthReadsView: View {
    
    var books: [MonthlyReadBook] = [
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv")
    ]
    
    var body: some View {
        ZStack {
            Image("march-bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
            
            VStack {
                ZStack {
                    Image("monthly-reads-title-bg")
                    Text("March Reads")
                        .font(.amithenRegular(size: 42))
                        .foregroundColor(.customBlack)
                }
                
                Spacer()
                
                LazyVGrid(columns:
                            [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 24) {
                                ForEach(books) { book in
                                    BookCard(book.imageUrl)
                                }
                            }
                            .padding(.horizontal, 16)
                Spacer()
                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal, 22)
        }
        
    }
    
    @ViewBuilder func BookCard(_ url: String) -> some View {
        WebImageView(url: URL(string: url))
            .frame(width: 87.64, height: 139.89)
            .cornerRadius(8)
    }
}

struct MonthlyReadBook: Hashable, Identifiable {
    let id = UUID()
    let imageUrl: String
}

struct MonthReadsView_Previews: PreviewProvider {
    static var previews: some View {
        MonthReadsView()
    }
}
