//
//  WatchCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Alamofire

protocol WatchCellViewModelProtocol: AnyObject {
    func didFetchProviderSuccess()
    func didFetchProviderFailure()
}

class WatchCellViewModel {
    
    private var movieDetail: MovieDetail?
    private var providerList: WatchProviders?
    private weak var delegate: WatchCellViewModelProtocol?
    
    public func setUpViewModel(movieDetail: MovieDetail, delegate: WatchCellViewModelProtocol) {
        self.movieDetail = movieDetail
        self.delegate = delegate
    }
    
    public func fetchWatchProviders() {
        AF.request(Api.getProviders(movieid: movieDetail?.id ?? 0), method: .get).validate().responseDecodable(of: WatchProviders.self) { response in
            switch response.result {
            case .success(let result):
                self.providerList = result
                self.delegate?.didFetchProviderSuccess()
            case .failure(_):
                self.delegate?.didFetchProviderFailure()
            }
        }
    }
    
    func getProvider(index: Int) -> Flatrate {
        providerList?.results?.br?.flatrate?[index] ?? Flatrate()
    }
    
    var getProviderCount: Int {
        providerList?.results?.br?.flatrate?.count ?? 0
    }
    
    var getSize: CGSize {
        CGSize(width: 50, height: 50)
    }
    
}
