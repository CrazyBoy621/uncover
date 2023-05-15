//
//  WebImageView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/05/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    
    @StateObject var imageManager: SDWebImageSwiftUI.ImageManager
    let url: URL?
    let defaultImage: String?
    init(url: URL?, defaultImage: String? = nil) {
        self._imageManager = StateObject(wrappedValue: SDWebImageSwiftUI.ImageManager())
        self.url = url
        self.defaultImage = defaultImage
    }
    
    var body: some View {
        Group {
            if (imageManager.image != nil) {
                Image(uiImage: imageManager.image!)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: defaultImage ?? "")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear { imageManager.load(url: url, options: .scaleDownLargeImages) }
        .onDisappear { imageManager.cancel() }
    }
}
