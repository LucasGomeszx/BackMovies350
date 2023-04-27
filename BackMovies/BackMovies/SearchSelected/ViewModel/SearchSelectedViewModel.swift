//
//  SearchSelectedViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

protocol SearchSelectedViewModelDelegate: AnyObject {
    func suss()
}

class SearchSelectedViewModel {
    
    private var service: Service = Service()
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
            let net = NetworkRequest(endpointURL: Api.genresMovies(id: genresMovies?.id ?? 0))
            service(link: net)
        case 2:
            let net = NetworkRequest(endpointURL: popularMovies ?? "")
            service(link: net)
        default:
            break
        }
    }
    
    private func service(link: NetworkRequest) {
        service.request(link) { (result: Result<Movies, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.movieList = success
                    self.delegate?.suss()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
}
