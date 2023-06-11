//
//  PublishingCollectionsView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 11/06/23.
//

import SwiftUI

struct PublishingCollectionsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var privateCollection = false
    @State var wantToRead = false
    @State var finished = false
    @State var started = false
    @State var captionTitle = ""
    @State private var start: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CollectionTitleData()
                CaptionView()
                SwitchToggles()
                AddedBooks()
            }
            .padding(.horizontal)
            .padding(.top, 24)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    NotificationCenter.default.post(name: Notification.Name("dismissPublishingCollectionsView"), object: nil)
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
                Button {
                    NotificationCenter.default.post(name: Notification.Name("dismissPublishingCollectionsView"), object: nil)
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
                    RoundedCornerShape(cornerRadius: 12, corners: [.topLeft, .topRight])
                        .fill(LinearGradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0)], startPoint: .top, endPoint: .bottom))
                        .frame(height: 38)
                    , alignment: .top
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
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Family dramas with huge....")
                    .font(.poppinsSemiBold(size: 16))
                    .foregroundColor(.customBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder func SwitchToggles() -> some View {
        VStack(spacing: 32) {
            VStack(spacing: 4) {
                GroupTitle(title: "preferences")
                Toggle(isOn: $privateCollection) {
                    Text("Set collections as private")
                }
                .tint(.mainColor)
            }
            VStack {
                GroupTitle(title: "bulk progress change")
                Toggle(isOn: $wantToRead) {
                    Text("Mark all books as want to read")
                }
                Toggle(isOn: $finished) {
                    Text("Mark all books as finished")
                }
                Toggle(isOn: $started) {
                    Text("Mark all books as started")
                }
            }
            .tint(.mainColor)
            .onChange(of: wantToRead) { newValue in
                if newValue {
                    finished = false
                    started = false
                }
            }
            .onChange(of: finished) { newValue in
                if newValue {
                    wantToRead = false
                    started = false
                }
            }
            .onChange(of: started) { newValue in
                if newValue {
                    wantToRead = false
                    finished = false
                }
            }
        }
    }
    
    @ViewBuilder func AddedBooks() -> some View {
        VStack(spacing: 24) {
            GroupTitle(title: "added books (7)")
            HStack (spacing: 16) {
                WebImageView(url: URL(string: "https://s3-alpha-sig.figma.com/img/1443/1daf/d33da3b75615926327a5c71b7d812a3d?Expires=1687132800&Signature=Fdm4eeYhy-PG266wUmOKKNLLf3v3LZXT8hifYrBU8dYUs3DpigA0-Gt3x8vnocfTVMziPRZ1fGpe45FOzb6qV6i4RWnfn9iP43uL1Zs2bXNMQRc90ILS1KDdr7gCxBDfypeZUj-5BUSsyVA-G0U~dMDIZOpkSztb2GnT-NWycZfFwnA9aCj3nf3lpITRlQpEx4kSBzqLf1pBBM4-iHf1L28ZRnZibhLXVpGtSTcGaHemJZI-aFC7DK8PgnYv6Thhc~8KUplZ7JDMctRCLUhs9SFLLBfeiNdLbbO07tTSNj0kMti4dXMDCrLzynrSgAccN3GrGK0CxOFd-3W58xbf8Q__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"))
                    .frame(width: 80, height: 125)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("The Martian")
                        .font(.system(size: 16, weight: .bold))
                    Text("Andy Weir")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.darkGrey)
                    
                    HStack(spacing: 20) {
                        Button {
                            
                        } label: {
                            HStack {
                                Text("Status")
                                Image(systemName: "chevron.down")
                            }
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.customPink)
                            .padding(.vertical, 8)
                            .padding(.leading)
                            .padding(.trailing, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.customPink, lineWidth: 0.4)
                            )
                        }
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("11 Jun 2023")
                        }
                        .foregroundColor(.customBlack)
                        .font(.poppinsRegular(size: 14))
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder func GroupTitle(title: String) -> some View {
        HStack {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.lightGrey)
            Spacer()
        }
    }
    
    @ViewBuilder func CaptionView() -> some View {
        VStack(spacing: -12) {
            TextEditorView(string: $captionTitle, placeholder: "Write caption", minHeight: 40, placeholderColor: .darkGrey)
                .offset(x: start ? 8 : 0)
                .onChange(of: captionTitle) { newValue in
                    let count = newValue.count - 396
                    if count > 0 {
                        captionTitle.removeLast(count)
                        start = true
                        withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                            start = false
                        }
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.error)
                    }
                }
            Divider()
            Text("\(captionTitle.count)/396")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.backgroundGrey)
                .padding(.top, 16)
        }
    }
}

struct PublishingCollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PublishingCollectionsView()
        }
        .accentColor(.mainColor)
    }
}
