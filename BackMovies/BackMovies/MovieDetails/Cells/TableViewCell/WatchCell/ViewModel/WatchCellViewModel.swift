//
//  WatchCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

class WatchCellViewModel {
    
    private var movie: Poster?
    private var providerList: [Int] = [1,2,3,4]
    
    public func setUpViewModel(movie: Poster) {
        self.movie = movie
    }
    
    var getProviderCount: Int {
        providerList.count
    }
    
    var getSize: CGSize {
        CGSize(width: 50, height: 50)
    }
    
}
