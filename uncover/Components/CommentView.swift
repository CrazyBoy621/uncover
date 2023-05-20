//
//  CommentView.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 21/05/23.
//

import SwiftUI

struct Comment: Identifiable {
    let id = UUID()
    let username: String
    let userIMG: String
    let commentText: String
    let likesCount: String
    let time: String
    let replies: [Comment]
}

struct CommentView: View {
    
    var comment: Comment
    @State var isRepliesHidden = false
    
    var body: some View {
        HStack(spacing: 12){
            VStack {
                WebImageView(url: URL(string: comment.userIMG))
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4){
                HStack{
                    Text(comment.username)
                        .font(.robotoBold(size: 16))
                    Spacer()
                    Text(comment.time)
                        .font(.robotoRegular(size: 16))
                        .foregroundColor(.darkGrey)
                }
                
                Text(comment.commentText)
                    .font(.robotoRegular(size: 16))
                
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
                    
                    Text(comment.likesCount)
                        .font(.robotoRegular(size: 14))
                        .foregroundColor(.lightGrey)
                    
                    Spacer()
                }
                
                if comment.replies.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Button {
                            isRepliesHidden.toggle()
                        } label: {
                            HStack{
                                Image(systemName: isRepliesHidden ? "chevron.up" : "chevron.down")
                                Text("\(isRepliesHidden ? "Hide" : "Show") replies")
                                Spacer()
                            }
                            .font(.robotoRegular(size: 16))
                        }
                        .padding(.vertical, 4)
                        
                        if isRepliesHidden{
                            ForEach(comment.replies) { replyComment in
                                CommentView(comment: replyComment)
                            }}
                    }
                }
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment:
                        Comment(
                            username: "Bekzod",
                            userIMG: "https://shorturl.at/bfvFK",
                            commentText: "This is sample comment",
                            likesCount: "12k likes",
                            time: "2 hours ago",
                            replies: [
                                Comment(
                                    username: "Bekzod",
                                    userIMG: "https://shorturl.at/bfvFK",
                                    commentText: "This is sample comment",
                                    likesCount: "12k likes",
                                    time: "2 hours ago",
                                    replies: []
                                ),
                                Comment(
                                    username: "Bekzod",
                                    userIMG: "https://shorturl.at/bfvFK",
                                    commentText: "This is sample comment",
                                    likesCount: "12k likes",
                                    time: "2 hours ago",
                                    replies: []
                                )
                            ]
                        )
        )
    }
}
