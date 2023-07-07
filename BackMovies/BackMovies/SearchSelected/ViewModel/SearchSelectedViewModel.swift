//
//  SearchSelectedViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Alamofire

enum MoviesType {
    case genres
    case movies
}

protocol SearchSelectedViewModelDelegate: AnyObject {
    func didFetchMoviesSuccess()
    func didFetchMoviesFailure()
}

class SearchSelectedViewModel {
    
    private var genresMovies: Genre?
    private var MyMovies: Movies?
    private var movieList: [Poster] = []
    private var page: Int = 1
    private var totalPages: Int = 1
    private var query: String = ""
    private weak var delegate: SearchSelectedViewModelDelegate?
    private var movieType: MoviesType
    
    init(type: MoviesType, genres: Genre?) {
        switch type {
        case .genres:
            movieType = type
            self.genresMovies = genres
        case .movies:
            movieType = type
        }
    }
    
    var getQuery: String {
        query
    }
    
    public func setUpDelegate(delegate: SearchSelectedViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getMoviesId(index: Int) -> Int {
        return movieList[index].id ?? 0
    }
    
    var getMoviesCount: Int {
        if movieList.count == 0 {
            return 1
        } else {
            return movieList.count
        }
    }
    
    var getMovieCellSize: CGSize {
        CGSize(width: 135, height: 260)
    }
    
    public func isArrayEmpty() -> Bool {
        if movieList.count == 0 {
            return true
        }else {
            return false
        }
    }
    
    public func getMainTitleLabel() -> String {
        switch movieType {
        case .genres:
            return genresMovies?.name ?? ""
        case .movies:
            return "Filmes"
        }
    }
    
    public func fetchMovies() {
        switch movieType {
        case .genres:
            self.getGenresMovies()
        case .movies:
            self.getPopularMovies()
        }
    }
    
    public func searchMovie(query: String) {
        self.query = query
        if !query.isEmpty {
            let encodedString = query.replacingOccurrences(of: " ", with: "%20")
            getQueryMovies(query: encodedString)
        }else {
            fetchMovies()
        }
    }
    
    public func getMoreMovies() {
        if page < totalPages {
            switch movieType {
            case .genres:
                getMoreGenresMovies()
            case .movies:
                getMorePopularMovies()
            }
        }
    }
    
    private func getGenresMovies() {
        page = 1
        self.movieList.removeAll()
        ServiceManeger.shared.getGenresMovies(genreId: genresMovies?.id ?? 0, page: page) { result in
            switch result {
            case .success(let success):
                self.page = success.page ?? 0
                self.totalPages = success.totalPages ?? 0
                self.MyMovies = success
                self.movieList = success.results ?? [Poster()]
                self.delegate?.didFetchMoviesSuccess()
            case .failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
    private func getMoreGenresMovies() {
        page += 1
        ServiceManeger.shared.getGenresMovies(genreId: genresMovies?.id ?? 0, page: page) { result in
            switch result {
            case .success(let success):
                self.page = success.page ?? 0
                self.movieList += success.results ?? [Poster()]
                self.delegate?.didFetchMoviesSuccess()
            case .failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
    private func getPopularMovies() {
        page = 1
        self.movieList.removeAll()
        ServiceManeger.shared.getPopularMovies(page: page) { result in
            switch result {
            case .success(let success):
                self.page = success.page ?? 0
                self.totalPages = success.totalPages ?? 0
                self.MyMovies = success
                self.movieList = success.results ?? [Poster()]
                self.delegate?.didFetchMoviesSuccess()
            case .failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
    private func getMorePopularMovies() {
        page += 1
        ServiceManeger.shared.getPopularMovies(page: page) { result in
            switch result {
            case .success(let success):
                self.page = success.page ?? 0
                self.movieList += success.results ?? [Poster()]
                self.delegate?.didFetchMoviesSuccess()
            case .failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
    private func getQueryMovies(query: String) {
        self.movieList.removeAll()
        ServiceManeger.shared.getQueryMovies(query: query) { result in
            switch result {
            case .success(let success):
                self.MyMovies = success
                self.movieList = success.results ?? [Poster()]
                self.delegate?.didFetchMoviesSuccess()
            case .failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
}
