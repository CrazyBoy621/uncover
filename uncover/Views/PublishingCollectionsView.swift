//
//  PublishingCollectionsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 11/06/23.
//

import SwiftUI

struct PublishingCollectionsView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            CollectionTitleData()
        }
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
                    Text("Family dramas")
                        .font(.poppinsBold(size: 20))
                        .foregroundColor(.customBlack)
                }
                ToolbarItem {
                    NavigationLink {
                        AddBooksToCollectionView()
                    } label: {
                        Text("Done")
                            .font(.poppinsSemiBold(size: 16))
                    }
                    
                }
            }
    }
    
    @ViewBuilder func CollectionTitleData() -> some View {
        HStack(spacing: 24) {
            WebImageView(url: URL(string: "https://s3-alpha-sig.figma.com/img/f1af/8c51/36b8551759e45851870011c50b4d66e8?Expires=1687132800&Signature=METRofBmLwJyQumGWKiiAbjmn-3cJoLSo-bfNsw5H1DIbQSIzWCB8la2O-ZfKeFCE0TlKDlxlviNjFHmq6b-LsIcr-FAxxOdYcSKXAXObjqrDRmraUED2Xa5LvmcgPas9wSWublWS8iauoHxbWehqC93jySqY0zjnPkv7tmliqO9xQcBmWqPYPdHqNw8PuWgD1IKRoVO35HHx0V3rtgd7ORPZilaG0JBLPVn6y2VqxjfhLkXrDJOuEvWvzAS1QWwK1ZtH18u5i54oQOUjlADby1mSqlmCbeFEGFikobc8ltsEHJG8JoEd~iXqo6KJgrNnXH10UeGvQorGuLJjADt7g__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"))
                .frame(width: 83, height: 103)
                .cornerRadius(12)
                .overlay (
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0)], startPoint: .top, endPoint: .bottom))
                        .frame(height: 38)
                )
                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 4)
            
            VStack(spacing: 16) {
                HStack(spacing: 8){
                    WebImageView(url: URL(string: "https://s3-alpha-sig.figma.com/img/92e7/a21a/a3e6b63ca8f297b5427deb43ff77e337?Expires=1687132800&Signature=blqi~ZBxcTiCiN2u9xplbDF1GNUvKgTBg07tou46ZRoCtrlG0yXyeBUTQMH8ZnR652jAzCOn76VMILOSJvvzgwERnOsmhw-bnzUU945BmCa7scnEYag4dBETkjcbT1vlKTtpri87QmFIy6228b3bZXZUzpP5TU4VJ3aPBxuSncqZGHjsdql6IhnXTJ6SGtdjAaDnV8ZAiYigEF24NWmauWYd1G4Bq04~i2OvN2l8rHiQeG5xEj1fZ6HU~GaLZtcRBDxXidCa6XHjqo~cdcwtOAfApcLieYPp0hmwdu4c2LKvEF3hAZHt4A-SbPkgzDUmkjRWrE6TVlRWZPySddFGSA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"))
                        .frame(width: 24, height: 24)
                        .cornerRadius(12)
                    
                    Text("tiredoflovesongs")
                        .font(.robotoMedium(size: 14))
                        .foregroundColor(.customBlack)
                }
                
                Text("Family dramas with huge....")
                    .font(.poppinsSemiBold(size: 16))
                    .foregroundColor(.customBlack)
            }
        }
    }
}

struct PublishingCollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        PublishingCollectionsView()
    }
}
