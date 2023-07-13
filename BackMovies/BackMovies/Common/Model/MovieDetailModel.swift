//
//  MovieDetailModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 12/07/23.
//

import Foundation

struct MovieDetailModel {
    var movieCellModel: MovieCellModel?
    var movieVideo: Video?
    var movieProvider: WatchProviders?
    var movieCast: CastModel?
    var similarMovies: MoviesModel?
}
