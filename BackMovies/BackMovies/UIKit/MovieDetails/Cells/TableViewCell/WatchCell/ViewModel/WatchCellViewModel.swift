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
    
    private var movieDetail: MovieDetailModel?
    private weak var delegate: WatchCellViewModelProtocol?
    
    public func setUpViewModel(movieDetail: MovieDetailModel, delegate: WatchCellViewModelProtocol) {
        self.movieDetail = movieDetail
        self.delegate = delegate
    }
    
    func getProvider(index: Int) -> Flatrate {
        movieDetail?.movieProvider?.results?.br?.flatrate?[index] ?? Flatrate()
    }
    
    var getProviderCount: Int {
        if movieDetail?.movieProvider?.results?.br?.flatrate?.count == nil {
            return 1
        }else {
            return movieDetail?.movieProvider?.results?.br?.flatrate?.count ?? 0
        }
    }
    
    var isEmpty: Bool {
        if movieDetail?.movieProvider?.results?.br?.flatrate?.count == nil {
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
