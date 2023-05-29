//
//  SearchViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Alamofire

protocol SearchViewModelDelegate: AnyObject {
    func didFetchGenresSucess()
    func didFetchGenresFailure()
}

class SearchViewModel {
    
    private var genresList: APIGenres?
    private weak var delegate: SearchViewModelDelegate?
    
    public func setUpDelegate(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchGenres() {
        AF.request(Api.apiGenres, method: .get).validate().responseDecodable(of: APIGenres.self) { response in
            switch response.result {
            case .success(let result):
                self.genresList = result
                self.delegate?.didFetchGenresSucess()
            case .failure(_):
                self.delegate?.didFetchGenresFailure()
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
