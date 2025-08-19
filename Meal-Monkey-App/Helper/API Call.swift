//
//  API Call.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 16/08/25.
//

import Foundation

/**
 A utility class for making generic API calls.

 This class provides a static method to fetch data from a given URL,
 which is then decoded into a specified Codable model.
 */
class APICalls {
    
    /**
     Fetches data from a URL and decodes it into an array of Codable objects.
     
     This is a generic method that can be used for any API endpoint that returns
     an array of a `Codable` type. It handles common network errors and decoding failures.
     
     - Parameters:
        - urlString: The URL string of the API endpoint.
        - completion: A closure that is called when the API request is complete.
                      It returns an array of the decoded Codable objects.
     */
    class func getData<T: Codable>(from urlString: String, completion: @escaping ([T]) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL:", urlString)
            completion([])
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Network error:", error)
                completion([])
                return
            }
            
            guard let data = data else {
                print("Empty response data")
                completion([])
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode([T].self, from: data)
                completion(decoded)
            } catch {
                print("Decoding error:", error)
                completion([])
            }
        }
        task.resume()
    }
}
