//
//  PosterCollectionViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Alamofire

protocol PosterCollectionViewModelDelegate: AnyObject {
    func didFetchMovieDetailSuccess()
}

class PosterCollectionViewModel {
    
    private var movieId: Int
    private var service: Service = Service()
    private var movieDetail: MovieDetail?
    private weak var delegate: PosterCollectionViewModelDelegate?
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    var getMovieDetailName: String {
        movieDetail?.title ?? ""
    }
    
    var getMovieDetailPoster: String {
        movieDetail?.posterPath ?? ""
    }
    
    public func setUpDelegate(delegate: PosterCollectionViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchMovieDetail() {
        AF.request(Api.movieDetail(id: movieId), method: .get).validate().responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case .success(let result):
                self.movieDetail = result
                self.delegate?.didFetchMovieDetailSuccess()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
