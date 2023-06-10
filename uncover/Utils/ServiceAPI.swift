//
//  ServiceAPI.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 18/05/23.
//

import Foundation

class ServiceAPI {
    
    static let shared = ServiceAPI()
    
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
            request.setValue("Ebm32X8XRRy0BZOQRfGndwU4GAIRPcEVouadOqpUOIAL77baABpzBnHfnIiNnuqg", forHTTPHeaderField: "X-CSRFToken")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    // we will use data to decode to our object model
                // response can show status
                completion(data?.object, error?.localizedDescription)
                print(#function, data?.prettyPrintedJSONString, response, error)
            }
            task.resume()
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
