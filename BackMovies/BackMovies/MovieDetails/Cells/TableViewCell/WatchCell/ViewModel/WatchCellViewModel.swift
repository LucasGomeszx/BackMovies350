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
        ServiceManeger.shared.fetchWatchProviders(movieId: movieDetail?.id ?? 0) { result in
            switch result {
            case .success(let success):
                self.providerList = success
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
        if providerList?.results?.br?.flatrate?.count == nil {
            return 1
        }else {
            return providerList?.results?.br?.flatrate?.count ?? 0
        }
    }
    
    var isEmpty: Bool {
        if providerList?.results?.br?.flatrate?.count == nil {
            return true
        }else {
            return false
        }
    }
    
    var getProviderCellSize: CGSize {
        CGSize(width: 70, height: 70)
    }
    
    var getEmptyCellSize: CGSize {
        CGSize(width: 200, height: 60)
    }
    
}
