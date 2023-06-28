//
//  AddMissingBookView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 29/06/23.
//

import SwiftUI

struct AddMissingBookView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var bookImage = ""
    @State var bookTitle = ""
    @State var authorsNames = ""
    @State var description = ""
    @State var publisherName = ""
    @State var publishDate = ""
    @State var pageCount = ""
    @State var language = ""
    @State var isbn10Code = ""
    @State var isbn13Code = ""
    
    var body: some View {
        ScrollView {
            
            VStack {
                if bookImage.isEmpty {
                    bookSolidCover
                } else {
                    bookImageCover
                }
            }
            .padding(.top, 32)
            .padding(.bottom, 48)
            
            VStack(spacing: 24) {
                inputCell("title".localized, "title_placeholder".localized, value: $bookTitle)
                inputCell("authors".localized, "authors_placeholder".localized, value: $authorsNames)
                inputCell("description_input".localized, "description_input_placholder".localized, value: $description)
                inputCell("publisher_input".localized, "publisher_input_placeholder".localized, value: $publisherName)
                inputCell("publish_date".localized, "publish_date_placeholder".localized, value: $publishDate)
                inputCell("page_count".localized, "page_count_placeholder".localized, value: $pageCount)
                inputCell("language".localized, "language_placeholder".localized, value: $language)
                inputCell("isbn10_input".localized, "isbn10_input_placeholder".localized, value: $isbn10Code)
                inputCell("isbn13_input".localized, "isbn13_input_placeholder".localized, value: $isbn13Code)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            
            HStack(spacing: 16) {
                Button {
                        presentationMode.wrappedValue.dismiss()
                } label: {
                    CustomButton(title: "cancel".localized, foreground: .softBlue, background: .white)
                }
                Button {
                    
                } label: {
                    CustomButton(title: "done".localized, foreground: .white, background: .mainColor)
                }
            }
            .padding(.top, 48)
            .padding(.bottom)
        }
        .navigationTitle("add_a_book".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("add_a_book".localized)
                    .font(.poppinsBold(size: 20))
                    .foregroundColor(.customBlack)
            }
        }
    }
    
    var bookSolidCover: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(hex: "F2F2F2"))
            .frame(width: 109.86, height: 166)
            .shadow(color: Color.black.opacity(0.15), radius: 4, y: 4)
            .overlay(
                Button {
                    withAnimation {
                        bookImage = "https://designforwriters.com/wp-content/uploads/2017/10/design-for-writers-book-cover-tf-2-a-million-to-one.jpg"
                    }
                } label: {
                    Image("pencil")
                        .padding(-10)
                }
                , alignment: .bottomTrailing
            )
    }
    
    var bookImageCover: some View {
        WebImageView(url: URL(string: bookImage))
            .frame(width: 109.86, height: 166)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.15), radius: 4, y: 4)
            .overlay(
                Button {
                    
                } label: {
                    Image("pencil")
                        .padding(-10)
                }
                , alignment: .bottomTrailing
            )
    }
    
    @ViewBuilder func inputCell(_ title: String, _ placeholder: String, value: Binding<String>) -> some View {
        VStack(spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.lightGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(placeholder, text: value)
                .autocapitalization(.none)
            Divider()
        }
    }
}

struct AddMissingBookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddMissingBookView()
        }
    }
}
