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
    
    private let movieDetail: MovieDetailModel
    private var movieTrailer: [String] = []
    private var delegate: TrailerCellViewModelProtocol?
    
    init(movieDetail: MovieDetailModel) {
        self.movieDetail = movieDetail
    }
    
    var getOverview: String {
        guard let over = movieDetail.movieCellModel?.overview else {return "Sinopse indisponivel"}
        
        if over == "" {
            return "Sinopse indisponivel"
        } else {
            return over
        }
    }
    
    var getMovieVideoKey: String {
        filterTreilerVideo()
        if movieTrailer.isEmpty {
            return ""
        }else {
            return movieTrailer[0]
        }
    }
    
    private func filterTreilerVideo() {
        guard let video = movieDetail.movieVideo?.results else {return}
        for key in video {
            if key.type == "Trailer" {
                self.movieTrailer.append(key.key ?? "")
            }
        }
    }
    
}
