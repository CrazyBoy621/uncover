//
//  MonthReadsView.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 03/07/23.
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
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv"),
        MonthlyReadBook(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA2gvBPs_jbzIQa-laIY8rXUuR4kFMmMSZXyH_VS8ddWji9sv")
    ]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
