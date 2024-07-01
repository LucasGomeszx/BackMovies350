//
//  MovieDetailViewModelSwiftUI.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/06/24.
//

import Foundation
import Firebase
import FirebaseFirestore

enum MovieDetailStatus {
    case getfetching
    case success
}

class MovieDetailViewModelSwiftUI: ObservableObject {
    
    @Published var satus: MovieDetailStatus = .getfetching
    @Published var movieData: MovieCellModel
    @Published var isFavorite: Bool = false
    var movieDetail: MovieDetailModel?
    var movieTrailer: [String] = []
    
    init(movieData: MovieCellModel) {
        self.movieData = movieData
    }
    
    var getMovieVideoKey: String {
        filterTrailerVideo()
        return movieTrailer.first ?? ""
    }
    
    var getMovieName: String {
        movieData.title ?? ""
    }
    
    func getUserFavoriteMovies() {
        FirestoreManager.shared.isMovieInFavorites(movieId: movieData) { result in
            switch result {
            case .success(let isInFavorites):
                self.isFavorite = isInFavorites
            case .failure(_):
                self.isFavorite = false
            }
        }
    }
    
    func tappedHeartImage() {
        if !isFavorite {
            self.addFavoriteMovie()
            self.isFavorite = true
        }else {
            self.deleteFavoriteMovie()
            self.isFavorite = false
        }
    }
    
    func addFavoriteMovie() {
        FirestoreManager.shared.addFavoriteMovie(movieId: movieData) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("Erro ao adicionar filme aos favoritos no Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteFavoriteMovie() {
        FirestoreManager.shared.removeFavoriteMovie(movieId: movieData) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("Erro ao adicionar filme aos favoritos no Firestore: \(error.localizedDescription)")
            }
        }
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
        guard let video = movieDetail?.movieVideo?.results else { return }
        for key in video where key.type == "Trailer" {
            if let keyString = key.key {
                self.movieTrailer.append(keyString)
            }
        }
    }
    
    public func fetchMovieDetailsConcurrently(movieId: Int) async throws {
        async let video = SwiftUIServiceManeger.shered.fetchMovieVideo(movieId: movieId)
        async let watchProviders = SwiftUIServiceManeger.shered.fetchWatchProviders(movieId: movieId)
        async let actors = SwiftUIServiceManeger.shered.fetchActors(movieId: movieId)
        async let similarMovies = SwiftUIServiceManeger.shered.fetchSimilarMovies(movieId: movieId)

        do {
            let (videoResult, watchProvidersResult, actorsResult, similarMoviesResult) = try await (video, watchProviders, actors, similarMovies)
            movieDetail = MovieDetailModel(movieCellModel: movieData, movieVideo: videoResult, movieProvider: watchProvidersResult, movieCast: actorsResult, similarMovies: similarMoviesResult)
            DispatchQueue.main.async {
                self.satus = .success
            }
        } catch {
            throw error
        }
    }
    
}
