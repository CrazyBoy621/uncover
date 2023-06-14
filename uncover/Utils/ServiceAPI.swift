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
        completion("2fG8CFtYNxQZFOapcr54aBaDrjFTnYxoUA5lunigkA1lvCnaJUPL836AW6DjjMX1")
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
        completion: @escaping([String: Any]?, String?) -> ()) {
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
                    // we will use data to decode to our object model
                    // response can show status
                    completion(data?.object, error?.localizedDescription)
                    print(#function, data?.prettyPrintedJSONString, response, error)
                }
                task.resume()
            }
        }
    
    func getBooksList(languageCode: String, search: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: bookList, languageCode) + "?search=\(search)"
            
            if let page = page {
                urlString += "&page=\(page)"
            }
            
            if let pageSize = pageSize {
                urlString += "&page_size=\(pageSize)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, "Invalid URL")
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
    
    func getBooksByTag(tagName: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([String: Any]?, String?) -> ()) {
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
    
    func getBooksById(bookId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: booksById, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, "Invalid URL")
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
    
    //    PUT "/v1/books/{book_id}/cover/"
    //    DELETE "/v1/books/{book_id}/cover/"
    
    func getBookFeaturedInPreview(bookId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: featuredInPreview, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, "Invalid URL")
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
    
    func getBookFeaturedIn(bookId: String, ordering: String? = nil, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            var urlString = baseURL + String(format: featuredIn, bookId)
            
            if let ordering = ordering {
                urlString += "?ordering=\(ordering)"
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil, "Invalid URL")
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
    
    func getBookLikes(bookId: String, completion: @escaping ([String: Any]?, String?) -> ()) {
        getToken { token in
            let urlString = baseURL + String(format: bookLikes, bookId)
            
            guard let url = URL(string: urlString) else {
                completion(nil, "Invalid URL")
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
