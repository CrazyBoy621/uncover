//
//  HomeModuleListing.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 19/05/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var homeModuleListings: [HomeModuleListing] = []
    
    init(){
        fetchHomeModuleListings()
    }
    
    func fetchHomeModuleListings() {
        ServiceAPI.shared.fetchHomeModuleListings { [weak self] homeModuleListings, error in
            if let error = error {
                print("Error fetching home module listings: \(error)")
            } else if let homeModuleListings = homeModuleListings {
                DispatchQueue.main.async {
                    self?.homeModuleListings = homeModuleListings
                }
            }
        }
    }
}

struct HomeModuleListing: Codable {
    let id: String
    let name: String
    let decks: String
    let allDecksCount: String
    let books: String
    let allBooksCount: String
}
