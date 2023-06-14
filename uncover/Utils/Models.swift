//
//  Models.swift
//  uncover
//
//  Created by Shohjahon Rakhmatov on 14/06/23.
//

import Foundation

// MARK: - Welcome
struct GetBooksListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [BookData]
}

// MARK: - Result
struct BookData: Codable {
    let id, googleBooksID, title, description: String
    let authors: [Author]
    let mainCoverLink: String
    let likesCount, commentsCount: Int
    let createdAt: String
    let updatedAt: String
    let isLikedByYou: Bool
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case googleBooksID = "google_books_id"
        case title, description, authors
        case mainCoverLink = "main_cover_link"
        case likesCount = "likes_count"
        case commentsCount = "comments_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isLikedByYou = "is_liked_by_you"
        case status
    }
}

// MARK: - Author
struct Author: Codable {
    let id, name: String
}

struct Reaction: Codable {
    let description: String
}
