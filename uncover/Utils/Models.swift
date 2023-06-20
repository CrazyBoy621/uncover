//
//  Models.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 14/06/23.
//

import Foundation

// MARK: - Error RESPONSE
struct ErrorResponse: Codable {
    let detail: String?
}

// MARK: - Author
struct AuthorResponse: Codable {
    let id, name: String?
}

// MARK: - Book Listing
struct BookListingResponse: Codable {
    let id, googleBooksID, title, description: String?
    let authors: [AuthorResponse]?
    let mainCoverLink: String?
    let likesCount, commentsCount: Int?
    let createdAt, updatedAt: String?
    let isLikedByYou: Bool?
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

// MARK: - Publisher
struct PublisherResponse: Codable {
    let id, name: String?
}

// MARK: - Genre
struct GenreResponse: Codable {
    let id, name: String?
}

// MARK: - Book Cover
struct BookCoverResponse: Codable {
    let id, link, cover, userProfile, createdAt: String?
    enum CodingKeys: String, CodingKey {
        case id, link, cover
        case userProfile = "user_profile"
        case createdAt = "created_at"
    }
}

// MARK: - Book Thumbnail
struct BookThumbnailResponse: Codable {
    let id: String?
    let link: String?
}

// MARK: - Book
struct BookResponse: Codable {
    let id, googleBooksID, title: String?
    let authors: [AuthorResponse]?
    let publishers: [PublisherResponse]?
    let genres: [GenreResponse]?
    let bookTags: String?
    let tagsCount, decksCount: Int?
    let covers: [BookCoverResponse]?
    let thumbnails: [BookThumbnailResponse]?
    let likesCount: Int?
    let isLikedByYou: Bool?
    let bookStatus: String?
    let mainCoverLink: String?
    let hasFeaturedInDecks, hasReaders, hasSimilarBooks: Bool?
    let goodreadsID: String?
    let subtitle, description: String?
    let mainCover: String?
    let mainThumbnailLink: String?
    let pageCount: Int?
    let languageCode: String?
    let publishedDate: String?
    let isbn10, isbn13, otherIdentifiers: [String]?
    let googleBooksRating, googleBooksRatingsCount, goodreadsRating, goodreadsRatingsCount: Int?
    let googleBooksPreviewLink: String?
    let firstSentence: String?
    let commentsCount: Int?
    let wasTagged: Bool?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case googleBooksID = "google_books_id"
        case title, authors, publishers, genres
        case bookTags = "book_tags"
        case tagsCount = "tags_count"
        case decksCount = "decks_count"
        case covers, thumbnails
        case likesCount = "likes_count"
        case isLikedByYou = "is_liked_by_you"
        case bookStatus = "book_status"
        case mainCoverLink = "main_cover_link"
        case hasFeaturedInDecks = "has_featured_in_decks"
        case hasReaders = "has_readers"
        case hasSimilarBooks = "has_similar_books"
        case goodreadsID = "goodreads_id"
        case subtitle, description
        case mainCover = "main_cover"
        case mainThumbnailLink = "main_thumbnail_link"
        case pageCount = "page_count"
        case languageCode = "language_code"
        case publishedDate = "published_date"
        case isbn10 = "isbn_10"
        case isbn13 = "isbn_13"
        case otherIdentifiers = "other_identifiers"
        case googleBooksRating = "google_books_rating"
        case googleBooksRatingsCount = "google_books_ratings_count"
        case goodreadsRating = "goodreads_rating"
        case goodreadsRatingsCount = "goodreads_ratings_count"
        case googleBooksPreviewLink = "google_books_preview_link"
        case firstSentence = "first_sentence"
        case commentsCount = "comments_count"
        case wasTagged = "was_tagged"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UserProfile
struct UserProfileResponse: Codable {
    let firebaseUid: String?
    let userId: String?
    let username: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let description: String?
    let isActive: String?
    let isAuthenticated: String?
    let isAnonymous: Bool?
    let registrationComplete: Bool?
    let dateJoined: String?
    let lastLogin: String?
    let photoURL: String?
    let followersCount: String?
    let followingCount: String?
    let followedDecksCount: String?
    let booksCount: String?
    let isFollowedByYou: String?
    let isYou: String?
    let isSuspended: Bool?
    let suspendedUntil: String?
    let activeLink: String?
    let isActiveLinkEnabled: Bool?
    
    enum CodingKeys: String, CodingKey {
        case firebaseUid = "firebase_uid"
        case userId = "user_id"
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case description
        case isActive = "is_active"
        case isAuthenticated = "is_authenticated"
        case isAnonymous = "is_anonymous"
        case registrationComplete = "registration_complete"
        case dateJoined = "date_joined"
        case lastLogin = "last_login"
        case photoURL = "photo_url"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case followedDecksCount = "followed_decks_count"
        case booksCount = "books_count"
        case isFollowedByYou = "is_followed_by_you"
        case isYou = "is_you"
        case isSuspended = "is_suspended"
        case suspendedUntil = "suspended_until"
        case activeLink = "active_link"
        case isActiveLinkEnabled = "is_active_link_enabled"
    }
}

// MARK: - DeckListing
struct DeckListingResponse: Codable {
    let id: String?
    let deckTagsCount: String?
    let booksCount: String?
    let userProfile: UserProfileResponse?
    let followersCount: String?
    let likesCount: String?
    let likingUsers: String?
    let isOwnedByYou: String?
    let isFollowedByYou: String?
    let isLikedByYou: String?
    let title: String?
    let description: String?
    let background: String?
    let isPublic: Bool?
    let commentsCount: Int?
    let viewsCount: Int?
    let isInappropriate: Bool?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case deckTagsCount = "deck_tags_count"
        case booksCount = "books_count"
        case userProfile = "user_profile"
        case followersCount = "followers_count"
        case likesCount = "likes_count"
        case likingUsers = "liking_users"
        case isOwnedByYou = "is_owned_by_you"
        case isFollowedByYou = "is_followed_by_you"
        case isLikedByYou = "is_liked_by_you"
        case title
        case description
        case background
        case isPublic = "public"
        case commentsCount = "comments_count"
        case viewsCount = "views_count"
        case isInappropriate = "inappropriate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Reaction
struct ReactionResponse: Codable {
    let id: String?
    let userProfile: UserProfileResponse?
    let likesCount: String?
    let repliesCount: String?
    let isLikedByYou: String?
    let isYours: String?
    let text: String?
    let photoURL: String?
    let createdAt: String
    let editedAt: String?
    let replyTo: String?
    let likes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userProfile = "user_profile"
        case likesCount = "likes_count"
        case repliesCount = "replies_count"
        case isLikedByYou = "is_liked_by_you"
        case isYours = "is_yours"
        case text
        case photoURL = "photo_url"
        case createdAt = "created_at"
        case editedAt = "edited_at"
        case replyTo = "reply_to"
        case likes
    }
}

// MARK: - BookReaction
struct BookReactionResponse: Codable {
    let id: String?
    let reaction: ReactionResponse?
    let book: String?
}

// MARK: - BookStatus
struct BookStatusResponse: Codable {
    let id: Int?
    let book: String?
    let user: String?
    let type: BookStatusType?
    let statusDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case book
        case user
        case type
        case statusDate = "status_date"
    }
}

enum BookStatusType: String, Codable {
    case wantToRead = "WANT_TO_READ"
    case startedReading = "STARTED_READING"
    case finished = "FINISHED"
    case stopped = "STOPPED"
    case none = "NONE"
}

// MARK: - BookTag
struct BookTagResponse: Codable {
    let id: Int?
    let tag: String?
    let count: Int?
    let addedByUser: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, tag, count
        case addedByUser = "added_by_user"
    }
}

// MARK: - BookTagPreview
struct BookTagPreviewResponse: Codable {
    let preview: [BookTagResponse]?
    let hashtagsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case preview
        case hashtagsCount = "hashtags_count"
    }
}

// MARK: - DeckFollower
struct DeckFollowerResponse: Codable {
    let user: UserProfileResponse?
    let created: String?
}

// MARK: - DeckDetails
struct DeckDetailsResponse: Codable {
    let id: String?
    let title: String?
    let books: String?
    let deckTagsCount: String?
    let booksCount: String?
    let readBooksCount: String?
    let userProfile: UserProfileResponse?
    let followersCount: String?
    let likesCount: String?
    let likingUsers: String?
    let isOwnedByYou: String?
    let isFollowedByYou: String?
    let isLikedByYou: String?
    let description: String?
    let background: String?
    let isPublic: Bool?
    let commentsCount: Int?
    let viewsCount: Int?
    let isInappropriate: Bool?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case books
        case deckTagsCount = "deck_tags_count"
        case booksCount = "books_count"
        case readBooksCount = "read_books_count"
        case userProfile = "user_profile"
        case followersCount = "followers_count"
        case likesCount = "likes_count"
        case likingUsers = "liking_users"
        case isOwnedByYou = "is_owned_by_you"
        case isFollowedByYou = "is_followed_by_you"
        case isLikedByYou = "is_liked_by_you"
        case description
        case background
        case isPublic = "public"
        case commentsCount = "comments_count"
        case viewsCount = "views_count"
        case isInappropriate = "inappropriate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK - Deck
struct DeckResponse: Codable {
    let id: String?
    let title: String?
    let books: [BookListingResponse]?
    let deckTagsCount: String?
    let booksCount: String?
    let readBooksCount: String?
    let userProfile: UserProfileResponse?
    let followersCount: String?
    let likesCount: String?
    let likingUsers: String?
    let isOwnedByYou: String?
    let isFollowedByYou: String?
    let isLikedByYou: String?
    let description: String?
    let background: String?
    let isPublic: Bool?
    let commentsCount: Int?
    let viewsCount: Int?
    let isInappropriate: Bool?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case books
        case deckTagsCount = "deck_tags_count"
        case booksCount = "books_count"
        case readBooksCount = "read_books_count"
        case userProfile = "user_profile"
        case followersCount = "followers_count"
        case likesCount = "likes_count"
        case likingUsers = "liking_users"
        case isOwnedByYou = "is_owned_by_you"
        case isFollowedByYou = "is_followed_by_you"
        case isLikedByYou = "is_liked_by_you"
        case description
        case background
        case isPublic = "public"
        case commentsCount = "comments_count"
        case viewsCount = "views_count"
        case isInappropriate = "inappropriate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARk - DeckReaction
struct DeckReactionResponse: Codable {
    let id: String?
    let reaction: ReactionResponse?
    let deck: String?
}

// MARk - DeckTag
struct DeckTagResponse: Codable {
    let id: Int?
    let tag: String?
    let count: String?
    let addedByUser: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, tag, count
        case addedByUser = "added_by_user"
    }
}

// MARk - UserFollower
struct UserFollowerResponse: Codable {
    let user: UserProfileResponse?
    let created: String?
}

// MARK - HomeModuleListing
struct HomeModuleListing: Codable {
    let id: String?
    let name: String?
    let decks: String?
    let allDecksCount: String?
    let books: String?
    let allBooksCount: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case decks
        case allDecksCount = "all_decks_count"
        case books
        case allBooksCount = "all_books_count"
    }
}

// MARK - HomeModule
struct HomeModule: Codable {
    let id: String?
    let decks: String?
    let books: String?
    let name: String?
    let order: Int?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case decks
        case books
        case name
        case order
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - AppVersion
struct AppVersion: Codable {
    let id: String?
    let name: String?
    let versionCode: Int?
    let priority: Int?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, priority, description
        case versionCode = "version_code"
    }
}

// MARK: - InitialData
struct InitialDataResponse: Codable {
    let id: Int?
    let appVersions: [AppVersion]?
    let isBeAvailable: Bool?
    let minAndroidAppVersion, currentTermsOfUseVersion: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case appVersions = "app_versions"
        case isBeAvailable = "is_be_available"
        case minAndroidAppVersion = "min_android_app_version"
        case currentTermsOfUseVersion = "current_terms_of_use_version"
    }
}

// MARK - UserProfilePicture
struct UserProfilePictureResponse: Codable {
    let id, profilePicture, createdAt, updatedAt, userProfile: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case profilePicture = "profile_picture"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userProfile = "user_profile"
    }
}

// MARK - Tag
struct TagResponse: Codable {
    let id: String?
    let name: String?
    let booksCount: Int?
    let decksCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case booksCount = "books_count"
        case decksCount = "decks_count"
    }
}

// MARK - TrendingBook
struct TrendingBookResponse: Codable {
    let book: String?
    
    enum CodingKeys: String, CodingKey {
        case book
    }
}

// MARK - TrendingDeck
struct TrendingDeckResponse: Codable {
    let deck: String?
    
    enum CodingKeys: String, CodingKey {
        case deck
    }
}

// MARK - TrendingHashtag
struct TrendingHashtagResponse: Codable {
    let tag: String?
    
    enum CodingKeys: String, CodingKey {
        case tag
    }
}

// MARK - TrendingUser
struct TrendingUserResponse: Codable {
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case profile
    }
}

// MARK - FollowedDeck
struct FollowedDeckResponse: Codable {
    let deck: DeckListingResponse?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case deck
        case created
    }
}

// MARK - UserHighlightStoryListing
struct UserHighlightStoryListing: Codable {
    let id: String?
    let title: String?
    let background: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case background
    }
}

// MARK - UserHighlightStory
struct UserHighlightStory: Codable {
    let id: String?
    let title: String?
    let background: String?
    let highlights: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case background
        case highlights
    }
}
