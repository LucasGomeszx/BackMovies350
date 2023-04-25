//
//  Api.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 18/04/23.
//

import Foundation

struct Api {
    
    static func posterUrl() -> String {
        return "https://api.themoviedb.org/3/movie/now_playing?api_key=a418c1d2207524b9f775ba6cb3c50ad6&language=pt-BR&region=BR&page=1"
    }
    
    static let posterPath: String = "https://image.tmdb.org/t/p//w500"
    
    static func actorDetail(id: Int) -> String {
        "https://api.themoviedb.org/3/person/\(id)?api_key=a418c1d2207524b9f775ba6cb3c50ad6&language=pt-BR"
    }
    
    static func actor(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=a418c1d2207524b9f775ba6cb3c50ad6"
    }
    
    static func similarMovies(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=a418c1d2207524b9f775ba6cb3c50ad6&language=pt-BR&page=1"
    }
    
}
