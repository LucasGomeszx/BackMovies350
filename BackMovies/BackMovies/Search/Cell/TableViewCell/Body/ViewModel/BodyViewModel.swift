//
//  BodyViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

class BodyViewModel {
    
    private var genresList: APIGenres?
    
    var getGenresListCount: Int {
        genresList?.genres?.count ?? 0
    }
    
    var getBodyCollectionCellSize: CGSize {
        CGSize(width: 150, height: 125)
    }
    
    public func getGenres(index: Int) -> Genre {
        genresList?.genres?[index] ?? Genre()
    }
    
    public func setGenresList(genreList: APIGenres) {
        self.genresList = genreList
    }
    
}
