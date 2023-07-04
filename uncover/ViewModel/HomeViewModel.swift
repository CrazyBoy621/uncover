//
//  HomeViewModel.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 01/07/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    func fetchCollectionFeed(completion: @escaping (DeckListingResponse?, String?) -> Void) {
        ServiceAPI.shared.postCollectionFeed(excludedDeckIds: [""]) { deckListingResponse, error in
            // Handle the completion here
            completion(deckListingResponse, error)
        }
    }
}
