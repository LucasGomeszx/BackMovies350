//
//  MovieDetailViewModelSwiftUI.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/06/24.
//

import Foundation

enum MovieDetailStatus {
    case getfetching
    case success
}

class MovieDetailViewModelSwiftUI: ObservableObject {
    
    @Published var satus: MovieDetailStatus = .getfetching
    @Published var movieData: MovieCellModel
    var movieDetail: MovieDetailModel?
    var movieCellDetail: MovieCellModel?
    var movieVideo: Video?
    var movieProvider: WatchProviders?
    var movieCast: CastModel?
    var similarMovies: MoviesModel?
    var movieTrailer: [String] = []
    
    init(movieData: MovieCellModel) {
        self.movieData = movieData
        fetchMovieDetail()
    }
    
    var getMovieVideoKey: String {
        filterTrailerVideo()
        return movieTrailer.first ?? ""
    }
    
    var getMovieName: String {
        movieData.title ?? ""
    }
    
    var getUrlYoutube: URL {
        let movieName = getMovieName
        let baseURLString = Api.youtubeLink()
        let query = movieName.replacingOccurrences(of: " ", with: "+")
        
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "\(baseURLString)?search_query=\(encodedQuery)") {
            return url
        }
        return URL(fileURLWithPath: "")
    }
    
    private func filterTrailerVideo() {
        guard let video = movieVideo?.results else { return }
        for key in video where key.type == "Trailer" {
            if let keyString = key.key {
                self.movieTrailer.append(keyString)
            }
        }
    }
    
    public func fetchMovieDetail() {
        ServiceManeger.shared.fetchMovieVideo(movieId: movieData.id ?? 0) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.movieVideo = success
                    self.fetchWatchProviders()
                case .failure:
                    break
                }
            }
        }
    }
    
    private func fetchWatchProviders() {
        ServiceManeger.shared.fetchWatchProviders(movieId: movieData.id ?? 0) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.movieProvider = success
                    self.fetchActors()
                case .failure:
                    break
                }
            }
        }
    }
    
    private func fetchActors() {
        ServiceManeger.shared.fetchActors(movieId: movieData.id ?? 0) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.movieCast = success
                    self.fetchSimilarMovies()
                case .failure:
                    break
                }
            }
        }
    }
    
    private func fetchSimilarMovies() {
        ServiceManeger.shared.fetchSimilarMovies(movieId: movieData.id ?? 0) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.similarMovies = success
                    self.createMovieDetailModel()
                case .failure:
                    break
                }
            }
        }
    }
    
    private func createMovieDetailModel() {
        DispatchQueue.main.async {
            self.movieDetail = MovieDetailModel(movieCellModel: self.movieCellDetail, movieVideo: self.movieVideo, movieProvider: self.movieProvider, movieCast: self.movieCast, similarMovies: self.similarMovies)
            self.satus = .success
        }
    }
}
