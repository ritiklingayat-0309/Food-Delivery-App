//
//  API Call.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 16/08/25.
//

import Foundation


class APICalls {
    /// Generic API method to fetch data and decode into a codable model.
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
