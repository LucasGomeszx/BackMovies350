//
//  WatchCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Alamofire

class WatchCellViewModel {
    
    private var movieDetail: MovieDetail?
    private var providerList: WatchProviders?
    
    public func setUpViewModel(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    public func fetchWatchProviders() {
        AF.request(Api.getProviders(movieid: movieDetail?.id ?? 0), method: .get).validate().responseDecodable(of: WatchProviders.self) { response in
            switch response.result {
            case .success(let result):
                self.providerList = result
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var getProviderCount: Int {
        5
    }
    
    var getSize: CGSize {
        CGSize(width: 50, height: 50)
    }
    
}
