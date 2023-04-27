//
//  SearchViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func suss()
}

class SearchViewModel {
    
    private var genresList: APIGenres?
    private var service: Service = Service()
    private var delegate: SearchViewModelDelegate?
    
    public func setUpDelegate(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchGenres() {
        let net = NetworkRequest(endpointURL: Api.apiGenres)
        service.request(net) { (result: Result<APIGenres, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.genresList = success
                    self.delegate?.suss()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure.localizedDescription)
                }
            }
        }
    }
    var getGenresList: APIGenres {
        genresList ?? APIGenres()
    }
    
    var getTableViewCellCount: Int {
        2
    }
    
    var getHeadCellSize: CGFloat {
        220
    }
    
    var getBodyCellSize: CGFloat {
        CGFloat(((genresList?.genres?.count ?? 2) * 150) / 2)
    }
    
}
