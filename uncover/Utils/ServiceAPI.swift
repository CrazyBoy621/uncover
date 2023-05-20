//
//  ServiceAPI.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 18/05/23.
//

import Foundation

class ServiceAPI {
    static var shared = ServiceAPI()
    
    func fetchHomeModuleListings(completion: @escaping ([HomeModuleListing]?, Error?) -> Void) {
        let url = URL(string: "https://api-stage.theuncoverapp.com/api/v1/home-modules/")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("RESPONSE: ", response)
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NSError(domain: "com.example.api", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "com.example.api", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let homeModuleListings = try decoder.decode([HomeModuleListing].self, from: data)
                completion(homeModuleListings, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }


}


