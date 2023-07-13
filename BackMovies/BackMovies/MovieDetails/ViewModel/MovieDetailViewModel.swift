//
//  MovieDetailViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/04/23.
//

import Foundation
import Alamofire

protocol MovieDetailViewModelDelegate: AnyObject {
    func fetchMovieDetailSuccess()
    func fetchMovieDetailFailure(error: String)
}

class MovieDetailViewModel {
    
    private var movieDetail: MovieDetailModel?
    private var movieCellDetail: MovieCellModel
    private var movieVideo: Video?
    private var movieProvider: WatchProviders?
    private var movieCast: CastModel?
    private var similarMovies: MoviesModel?
    private weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieCellModel: MovieCellModel){
        movieCellDetail = movieCellModel
    }
    
    private var getMovieId: Int {
        movieCellDetail.id ?? 0
    }
    
    public func setUpDelegate(delegate: MovieDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    var getMovieName: String {
        movieCellDetail.title ?? ""
    }
    
    var getTableViewCellCount: Int {
        6
    }
    
    var getMovieTopCellSize: CGFloat {
        640
    }
    
    var getWatchCellSize: CGFloat {
        250
    }
    
    var getActorCellSize: CGFloat {
        300
    }
    
    var getRelatedCell: CGFloat {
        340
    }
    
    var getMapCellSize: CGFloat {
        250
    }
    
    var getMovieDetail: MovieDetailModel {
        movieDetail ?? MovieDetailModel()
    }
    
    func getTrailerCellSize(width: CGFloat) -> CGFloat {
        let text = movieCellDetail.overview ?? ""
        let font = UIFont.systemFont(ofSize: 14)
        let estimateHeight = text.heightWithConstrainedWidth(width: width, font: font)
        return estimateHeight + 380
    }
    
    func searchMovieOnYouTube() {
        let movieName = getMovieName
        let baseURLString = Api.youtubeLink()
        let query = movieName.replacingOccurrences(of: " ", with: "+")
        
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "\(baseURLString)?search_query=\(encodedQuery)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    public func fetchMovieDetail() {
        ServiceManeger.shared.fetchMovieVideo(movieId: getMovieId) { result in
            switch result {
            case .success(let success):
                self.movieVideo = success
                self.fetchWatchProviders()
            case .failure(let failure):
                self.delegate?.fetchMovieDetailFailure(error: failure.localizedDescription)
            }
        }
    }
    
    private func fetchWatchProviders() {
        ServiceManeger.shared.fetchWatchProviders(movieId: getMovieId) { result in
            switch result {
            case .success(let success):
                self.movieProvider = success
                self.fetchActors()
            case .failure(let failure):
                self.delegate?.fetchMovieDetailFailure(error: failure.localizedDescription)
            }
        }
    }
    
    private func fetchActors() {
        ServiceManeger.shared.fetchActors(movieId: getMovieId) { result in
            switch result {
            case .success(let success):
                self.movieCast = success
                self.fetchSimilarMovies()
            case .failure(let failure):
                self.delegate?.fetchMovieDetailFailure(error: failure.localizedDescription)
            }
        }
    }
    
    private func fetchSimilarMovies() {
        ServiceManeger.shared.fetchSimilarMovies(movieId: getMovieId) { result in
            switch result {
            case .success(let success):
                self.similarMovies = success
                self.createMovieDetailModel()
            case .failure(let failure):
                self.delegate?.fetchMovieDetailFailure(error: failure.localizedDescription)
            }
        }
    }
    
    private func createMovieDetailModel() {
        self.movieDetail = MovieDetailModel(movieCellModel: movieCellDetail, movieVideo: movieVideo, movieProvider: movieProvider, movieCast: movieCast, similarMovies: similarMovies)
        self.delegate?.fetchMovieDetailSuccess()
    }
    
}
