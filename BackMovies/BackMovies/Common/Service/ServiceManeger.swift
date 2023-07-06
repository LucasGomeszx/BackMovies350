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
    
    //MARK: - PosterCell
    
    public func fetchPosterCell(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        AF.request(Api.movieDetail(id: movieId), method: .get).validate().responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - MovieDetail
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        AF.request(Api.movieDetail(id: movieId), method: .get).validate().responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case.success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchMovieVideo(movieId: Int, completion: @escaping (Result<Video, Error>) -> Void) {
        AF.request(Api.movieView(movieId: movieId), method: .get).validate().responseDecodable(of: Video.self) { response in
            switch response.result {
            case.success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchWatchProviders(movieId: Int, completion: @escaping (Result<WatchProviders, Error>) -> Void) {
        AF.request(Api.getProviders(movieid: movieId), method: .get).validate().responseDecodable(of: WatchProviders.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchActors(movieId: Int, completion: @escaping (Result<Elenco, Error>) -> Void) {
        AF.request(Api.actor(id: movieId), method: .get).validate().responseDecodable(of: Elenco.self) { response in
            switch response.result {
            case.success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchSimilarMovies(movieId: Int, completion: @escaping (Result<SimilarMovies, Error>) -> Void) {
        AF.request(Api.similarMovies(id: movieId), method: .get).validate().responseDecodable(of: SimilarMovies.self) { response in
            switch response.result {
            case.success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
