//
//  ServiceManeger.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 06/07/23.
//

import Foundation
import Alamofire

class ServiceManeger {
    
    static let shared = ServiceManeger()
    
   //MARK: - PosterView
    public func fetchMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        AF.request(Api.posterUrl(page: 1), method: .get).validate().responseDecodable(of: Movies.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getMorePosterMovies(page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        AF.request(Api.posterUrl(page: page), method: .get).validate().responseDecodable(of: Movies.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
