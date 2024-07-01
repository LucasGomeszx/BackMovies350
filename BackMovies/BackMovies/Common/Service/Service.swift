//
//  Service.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/04/23.
//

import Foundation

class Service {

    func request<T: Decodable>(_ request: String) async throws -> T {
        guard let url = URL(string: request) else {
            throw NetworkError.invalidURL(url: request)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.decodeError(error: error)
        }
    }
    
}
