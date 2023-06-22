//
//  ServiceAPI.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 18/05/23.
//

import Foundation

class ServiceAPI {
    
    static let shared = ServiceAPI()
    
    func getToken(completion:@escaping (String) -> ()){
        //        completion("o44lqdhf2d1IMXULwOcuGFL2vga0vJtdgptyiV6xzgc4CL7w3hWbE7HZ038qrxTQ")
        completion("exArjPRnNkRcIeSaen5K6SNCEaswbPHshbxb5502vCD2EiS6yKvdZaNYJv1HjR5U")
//        completion("tPWDQFWy9V9JlyxPxMoK4AFWkPR2aCHMwtTnCV5dRdVzhCxLR9OdXSFipaqdiE5e")
    }
    
    func getInitialData(completion: @escaping(InitialDataResponse?, String?) -> ()) {
        getToken { token in
            let stringURL = baseURL + initialData
            
            guard let url = URL(string: stringURL) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(InitialDataResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    //MARK: - Book Form
    func postBookForm(
        title: String,
        authorNames: [String],
        bookCover: URL? = nil,
        description: String? = nil,
        publisherName: String? = nil,
        publishedDate: String? = nil,
        mainCoverLink: String? = nil,
        languageCode: String? = nil,
        isbn10: String? = nil,
        isbn13: String? = nil,
        pageCount: Int? = nil,
        completion: @escaping(BookListingResponse?, String?) -> ()) {
            getToken { token in
                var params = [String: Any]()
                params["title"] = title
                params["author_names"] = authorNames
                if let bookCover = bookCover {
                    params["book_cover"] = bookCover
                }
                if let description = description {
                    params["description"] = description
                }
                if let publisherName = publisherName {
                    params["publisher_name"] = publisherName
                }
                if let publishedDate = publishedDate {
                    params["published_date"] = publishedDate
                }
                if let mainCoverLink = mainCoverLink {
                    params["main_cover_link"] = mainCoverLink
                }
                if let languageCode = languageCode {
                    params["language_code"] = languageCode
                }
                if let isbn10 = isbn10 {
                    params["isbn10"] = isbn10
                }
                if let isbn13 = isbn13 {
                    params["isbn13"] = isbn13
                }
                if let pageCount = pageCount {
                    params["page_count"] = pageCount
                }
                let stringURL = baseURL + bookForm
                
                guard let url = URL(string: stringURL) else {
                    completion(nil, invalidURLError)
                    return
                }
                var request = URLRequest(url: url, timeoutInterval: 8)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(nil, error.localizedDescription)
                        return
                    }

                    guard let data = data, let response = response as? HTTPURLResponse else {
                        completion(nil, "Failed to get the data!")
                        return
                    }

                    if response.statusCode == 200 {
                        do {
                            let value = try JSONDecoder().decode(BookListingResponse.self, from: data)
                            completion(value, nil)
                        } catch {
                            completion(nil, error.localizedDescription)
                        }
                    } else {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            completion(nil, errorResponse.detail)
                        } catch {
                            completion(nil, "Failed to get the data!")
                        }
                    }
                }
                
                task.resume()
            }
        }
    
    func getBooksList(languageCode: String, search: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (BookListingResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: bookList, languageCode) + "?search=\(search)"
            
            if let page = page {
                urlString += "&page=\(page)"
            }
            
            if let pageSize = pageSize {
                urlString += "&page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBooksByTag(tagName: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (BookListingResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: booksByTag, tagName)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBooksById(bookId: String, completion: @escaping (BookResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: booksById, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func updateBookCover(bookId: String, bookCover: String, completion: @escaping (BookResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookIdCover, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "book_cover": bookCover
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteBookCover(bookId: String, completion: @escaping (BookResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookIdCover, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [:]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBookFeaturedInPreview(bookId: String, completion: @escaping (DeckListingResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: featuredInPreview, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBookFeaturedIn(bookId: String, ordering: String? = nil, completion: @escaping (DeckListingResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: featuredIn, bookId)
            
            if let ordering = ordering {
                urlString += "?ordering=\(ordering)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBookLikes(bookId: String, completion: @escaping (UserProfileResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookLikes, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserProfileResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postBookLikes(bookId: String, userId: String, completion: @escaping (BookResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookLikes, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteBookLikes(bookId: String, userId: String, completion: @escaping (BookResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookLikes, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBookReaction(bookId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (BookReactionResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: bookReaction, bookId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postBookReaction(bookId: String, firebaseUID: String, replyToId: String?, reactionDescription: String, completion: @escaping (BookReactionResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookReaction, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            var requestBody: [String: Any] = [
                "firebase_uid": firebaseUID,
                "reaction": [
                    "description": reactionDescription
                ]
            ]
            
            if let replyToId = replyToId {
                requestBody["reply_to_id"] = replyToId
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteBookReaction(bookId: String, reactionId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookReaction, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "reaction_id": reactionId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getBookReaderPreview(bookId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookReaderPreview, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getBooksReaders(bookId: String, bookStatusType: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: bookReaders, bookId) + "?search=\(bookStatusType)"
            
            if let page = page {
                urlString += "&page=\(page)"
            }
            
            if let pageSize = pageSize {
                urlString += "&page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func reportBook(bookId: String, reportingUserId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: reportBookEndpoint, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "reporting_user_id": reportingUserId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getSimilarBookPreview(bookId: String, completion: @escaping (BookListingResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: similarBooksPreview, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getSimilarBooks(bookId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (BookListingResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: similarBooksEndpoint, bookId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBookStatus(bookId: String, userId: String, completion: @escaping (BookStatusResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookStatusEndpoint, bookId, userId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookStatusResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func updateBookStatus(bookId: String, userId: String, status: String, completion: @escaping (BookStatusResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookStatusEndpoint, bookId, userId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "type": status
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookStatusResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBookTag(bookId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([BookTagResponse]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: bookTagEndpoint, bookId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([BookTagResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postBookTag(bookId: String, tagName: String, completion: @escaping (BookResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookTagEndpoint, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "name": tagName
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getBookTagsPreview(bookId: String, completion: @escaping (BookTagPreviewResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookTagPreviewEndpoint, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(BookTagPreviewResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postDeckFollowers(userId: String, deckId: String, completion: @escaping (DeckFollowerResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + deckFollowersEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId,
                "deck_id": deckId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckFollowerResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteDeckFollowers(userId: String, deckId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + deckFollowersEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId,
                "deck_id": deckId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getDecks(search: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (DeckListingResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + getDecksEndpoint
            
            if let page = page {
                urlString += "&page=\(page)"
            }
            
            if let pageSize = pageSize {
                urlString += "&page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    //    ------------------------------------------
    
    func getDeckDetails(deckId: String, includeBooks: Bool? = nil, completion: @escaping (DeckDetailsResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: getDeckIdEndpoint, deckId)
            
            if let includeBooks = includeBooks {
                urlString += "?include_books=\(includeBooks)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckDetailsResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func updateDeck(deckId: String, title: String, description: String? = nil, background: String, isPublic: Bool? = nil, bookIds: [String]? = nil, completion: @escaping (DeckListingResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: getDeckIdEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            var data: [String: Any] = [
                "title": title,
                "description": description ?? "",
                "background": background,
            ]
            
            if let description = description {
                data["description"] = description
            }
            
            if let isPublic = isPublic {
                data["public"] = isPublic
            }
            if let bookIds = bookIds {
                data["book_ids"] = bookIds
            }
            
            do {
                let requestData = try JSONSerialization.data(withJSONObject: data)
                request.httpBody = requestData
            } catch {
                completion(nil, "Error encoding request data")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteDeck(deckId: String, completion: @escaping (String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: getDeckIdEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(error.localizedDescription)
                } else {
                    completion(nil)
                }
            }
            
            task.resume()
        }
    }

    func postBlockDeck(deckId: String, blockingUserID: String, completion: @escaping (String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: blockDeckEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let blockData = ["blocking_user_id": blockingUserID]
            do {
                let requestData = try JSONSerialization.data(withJSONObject: blockData)
                request.httpBody = requestData
            } catch {
                completion("Error encoding request data")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(error.localizedDescription)
                } else {
                    completion(nil)
                }
            }
            
            task.resume()
        }
    }

    func deleteBlockDeck(deckId: String, blockingUserID: String, completion: @escaping (String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: blockDeckEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let blockData = ["blocking_user_id": blockingUserID]
            do {
                let requestData = try JSONSerialization.data(withJSONObject: blockData)
                request.httpBody = requestData
            } catch {
                completion("Error encoding request data")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(error.localizedDescription)
                } else {
                    completion(nil)
                }
            }
            
            task.resume()
        }
    }

    func getDeckBooks(deckId: String, completion: @escaping ([BookListingResponse]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckBooksEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([BookListingResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
//    {Need to do}
//    POST /v1/decks/{deck_id}/books/
//    PATCH /v1/decks/{deck_id}/books/
    
    func deleteDeckBook(deckId: String, bookId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckBooksEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "book_id": bookId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getDeckFollowers(deckId: String, completion: @escaping ([DeckFollowerResponse]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckIdFollowersEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([DeckFollowerResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getDeckLikes(deckId: String, completion: @escaping ([UserProfileResponse]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckLikesEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([UserProfileResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postDeckLike(deckId: String, userId: String, completion: @escaping (DeckResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckLikesEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteDeckLike(deckId: String, userId: String, completion: @escaping (DeckResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckLikesEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getDeckReaction(deckId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (DeckReactionResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: deckReactionEndpoint, deckId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postDeckReaction(deckId: String, userId: String, reactionDescription: String, replyToId: String? = nil, completion: @escaping (DeckReactionResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckReactionEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            var requestBody: [String: Any] = [
                "firebase_uid": userId,
                "reaction": [
                    "description": reactionDescription
                ]
            ]
            
            if let replyToId = replyToId {
                requestBody["reply_to_id"] = replyToId
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteDeckReaction(deckId: String, reactionId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: deckReactionEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "reaction_id": reactionId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getReadBooksCount(deckId: String, completion: @escaping (Int?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: readBooksCountEndpoint, deckId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(Int.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func reportDeck(bookId: String, reportingUserId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: reportBookEndpoint, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "reporting_user_id": reportingUserId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getDeckTag(deckId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (DeckTagResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: deckTagEndpoint, deckId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(DeckTagResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
//    {Need to do}
//    POST /v1/feed/
    
    func postFollower(userId: String, followerUserId: String, completion: @escaping (UserFollowerResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + followersEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId,
                "follower_user_id": followerUserId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserFollowerResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteFollower(userId: String, followerUserId: String, completion: @escaping (UserFollowerResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + followersEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Create the request body data
            let requestBody: [String: Any] = [
                "user_id": userId,
                "follower_user_id": followerUserId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserFollowerResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getHomeModules(completion: @escaping (HomeModuleListingResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + homeModulesEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(HomeModuleListingResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getHomeModule(homeModuleId: String, completion: @escaping (HomeModuleResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: homeModuleByIdEndpoint, homeModuleId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(HomeModuleResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getHomeModuleBooks(homeModuleId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([BookListingResponse]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: homeModuleBooksEndpoint, homeModuleId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([BookListingResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getHomeModuleDecks(homeModuleId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([DeckListingResponse]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: homeModuleDecksEndpoint, homeModuleId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([DeckListingResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postNotificationRegister(userId: String, registrationToken: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + notificationRegisterEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "user_id": userId,
                "registration_token": registrationToken
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func postNotificationUnregister(userId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + notificationUnregisterEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "user_id": userId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func postNotificationsMarkRead(userId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + notificationsMarkkReadEndpoint
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "user_id": userId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func postUserNotifications(userId: String, newerThen: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: userNotificationsEndpoint, userId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "newer_then": newerThen
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
//    {Need to do}
//    /v1/notifications/{user_id}/unread-count/
//    /v1/notifications/{user_id}/{notification_id}/
    
    func postProfilePicture(userProfile: String, completion: @escaping (UserProfilePictureResponse?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + profilePictureEndpoint

            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }

            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")

            // Create the request body data
            var requestBody: [String: Any] = [
                "user_profile": userProfile
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserProfilePictureResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }

            task.resume()
        }
    }
    
    func getProfilePictures(id: String, completion: @escaping (UserProfilePictureResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: userProfilePictureEndpoint, id)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserProfilePictureResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func putProfilePicture(id: String, userProfile: String, completion: @escaping (UserProfilePictureResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: userProfilePictureEndpoint, id)

            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }

            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")

            // Create the request body data
            var requestBody: [String: Any] = [
                "user_profile": userProfile
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserProfilePictureResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }

            task.resume()
        }
    }
    
    func patchProfilePicture(id: String, userProfile: String, completion: @escaping (UserProfilePictureResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: userProfilePictureEndpoint, id)

            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }

            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")

            // Create the request body data
            let requestBody: [String: Any] = [
                "user_profile": userProfile
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserProfilePictureResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }

            task.resume()
        }
    }
    
    func deleteProfilePictures(id: String, completion: @escaping (UserProfilePictureResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: userProfilePictureEndpoint, id)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(UserProfilePictureResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getReaction(reactionId: String, completion: @escaping (ReactionResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: reactionEndpoint, reactionId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(ReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func putReaction(reactionId: String, reaction: String, completion: @escaping (ReactionResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: reactionEndpoint, reactionId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            var requestBody: [String: Any] = [
                "reaction": reaction
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(ReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getReactionLikes(reactionId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([UserProfileResponse]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: reactionLikesEndpoint, reactionId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([UserProfileResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postReactionLike(reactionId: String, userId: String, completion: @escaping (ReactionResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: reactionLikesEndpoint, reactionId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            var requestBody: [String: Any] = [
                "user_id": userId
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(ReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func deleteReactionLike(reactionId: String, userId: String, completion: @escaping (ReactionResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: reactionLikesEndpoint, reactionId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            var requestBody: [String: Any] = [
                "user_id": userId
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error creating request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(ReactionResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getReactionReplies(reactionId: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([ReactionResponse]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: reactionRepliesEndpoint, reactionId)
            
            if let page = page {
                urlString += "?page=\(page)"
            }
            
            if let pageSize = pageSize {
                let separator = (page != nil) ? "&" : "?"
                urlString += "\(separator)page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([ReactionResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func reportReaction(reactionId: String, reportingUserId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: reactionReportEndpoint, reactionId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            // Construct the request body
            let requestBody: [String: Any] = [
                "reporting_user_id": reportingUserId
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(nil, "Error encoding request body")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getTags(name: String, search: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + tagsEndpoint + "?name=\(name)$search=\(search)"
            
            if let page = page {
                urlString += "&page=\(page)"
            }
            
            if let pageSize = pageSize {
                urlString += "&page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                
                // Process the received data here
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictionary = json as? [String: Any] {
                            completion(dictionary, nil)
                        } else {
                            completion(nil, "Invalid response format")
                        }
                    } catch {
                        completion(nil, "Error decoding JSON response")
                    }
                } else {
                    completion(nil, "No data received")
                }
            }
            
            task.resume()
        }
    }
    
    func getTagWithId(Id: String, completion: @escaping (TagResponse?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: tagsIdEndpoint, Id)
            
            guard let url = URL(string: urlString) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode(TagResponse.self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getTrendingBooks(completion: @escaping([TrendingBookResponse]?, String?) -> ()) {
        getToken { token in
            let stringURL = baseURL + trendingBooksEndpoint
            
            guard let url = URL(string: stringURL) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([TrendingBookResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getTrendingDecks(completion: @escaping([TrendingDeckResponse]?, String?) -> ()) {
        getToken { token in
            let stringURL = baseURL + trendingDecksEndpoint
            
            guard let url = URL(string: stringURL) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([TrendingDeckResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getTrendingTags(completion: @escaping([TrendingHashtagResponse]?, String?) -> ()) {
        getToken { token in
            let stringURL = baseURL + trendingTagsEndpoint
            
            guard let url = URL(string: stringURL) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([TrendingHashtagResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getTrendingUsers(completion: @escaping([TrendingUserResponse]?, String?) -> ()) {
        getToken { token in
            let stringURL = baseURL + trendingUsersEndpoint
            
            guard let url = URL(string: stringURL) else {
                completion(nil, invalidURLError)
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 8)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-CSRFToken")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(nil, "Failed to get the data!")
                    return
                }

                if response.statusCode == 200 {
                    do {
                        let value = try JSONDecoder().decode([TrendingUserResponse].self, from: data)
                        completion(value, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(nil, errorResponse.detail)
                    } catch {
                        completion(nil, "Failed to get the data!")
                    }
                }
            }
            
            task.resume()
        }
    }
}

extension Data {
    
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
    var object: [String: Any]? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else { return nil }
        return object
    }
}
