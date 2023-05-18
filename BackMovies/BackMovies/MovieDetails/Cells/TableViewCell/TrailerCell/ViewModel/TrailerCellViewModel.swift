//
//  TrailerCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Alamofire

protocol TrailerCellViewModelProtocol: AnyObject {
    func didFetchMovieVideoSucess()
}

class TrailerCellViewModel {
    
    private let movieDetail: MovieDetail
    private var movieVideos: Video?
    private var movieTrailer: [String] = []
    private var delegate: TrailerCellViewModelProtocol?
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    func setupDelegate(delegate: TrailerCellViewModelProtocol) {
        self.delegate = delegate
    }
    
    var getOverview: String {
        guard let over = movieDetail.overview else {return "Sinopse indisponivel"}
        
        if over == "" {
            return "Sinopse indisponivel"
        } else {
            return over
        }
    }
    
    var getMovieVideoKey: String {
        if movieTrailer.isEmpty {
            return ""
        }else {
            return movieTrailer[0]
        }
    }
    
    private func filterTreilerVideo() {
        guard let video = movieVideos?.results else {return}
        for key in video {
            if key.type == "Trailer" {
                self.movieTrailer.append(key.key ?? "")
            }
        }
    }
    
    func fetchMovieVideo() {
        AF.request(Api.movieView(movieId: movieDetail.id ?? 0), method: .get).validate().responseDecodable(of: Video.self) { response in
            switch response.result {
            case.success(let result):
                self.movieVideos = result
                self.filterTreilerVideo()
                self.delegate?.didFetchMovieVideoSucess()
            case .failure(_):
                break
            }
        }
    }
    
}
