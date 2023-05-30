//
//  SearchSelectedViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Alamofire

protocol SearchSelectedViewModelDelegate: AnyObject {
    func didFetchMoviesSuccess()
    func didFetchMoviesFailure()
}

class SearchSelectedViewModel {
    
    private var genresMovies: Genre?
    private var popularMovies: String?
    private var movieList: Movies?
    private weak var delegate: SearchSelectedViewModelDelegate?
    private var code: Int?
    
    init(code: Int, genres: Genre?) {
        switch code {
        case 1:
            self.code = code
            self.genresMovies = genres
        case 2:
            self.code = code
            self.popularMovies = Api.popularMovies()
        default:
            break
        }
    }
    
    func getMoviesId(index: Int) -> Int {
        movieList?.results?[index].id ?? 0
    }
    
    var getMoviesCount: Int {
        movieList?.results?.count ?? 0
    }
    
    var getMovieCellSize: CGSize {
        CGSize(width: 135, height: 260)
    }
    
    public func getMainTitleLabel() -> String {
        switch code {
        case 1:
            return genresMovies?.name ?? ""
        case 2:
            return "Filmes"
        default:
            return ""
        }
    }
    
    public func setUpDelegate(delegate: SearchSelectedViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchMovies() {
        switch code {
        case 1:
           guard let net = URL(string: Api.genresMovies(id: genresMovies?.id ?? 0)) else { return }
            service(link: net)
        case 2:
            guard let net = URL(string: popularMovies ?? "") else { return }
            service(link: net)
        default:
            break
        }
    }
    
    private func service(link: URL) {
        AF.request(link, method: .get).validate().responseDecodable(of: Movies.self) { response in
            switch response.result {
            case .success(let result):
                self.movieList = result
                self.delegate?.didFetchMoviesSuccess()
            case .failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
}
