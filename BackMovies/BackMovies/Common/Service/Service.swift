//
//  Service.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/04/23.
//

import Foundation

protocol ServiceProtocol {
    func request<T>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>)
}

class Service: ServiceProtocol {
    
    func request<T>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>) {
        
        guard let url = URL(string: request.endpointURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do{
                let decode = JSONDecoder()
                let result = try decode.decode(T.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(NetworkError.decodeError))
            }

        }
        session.resume()
    }
    
}
