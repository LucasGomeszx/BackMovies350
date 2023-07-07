//
//  Api.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 18/04/23.
//

import Foundation

struct Api {
    
    private static let apiKey: String = "?api_key=a418c1d2207524b9f775ba6cb3c50ad6"
    
    static let posterPath: String = "https://image.tmdb.org/t/p//w500"
    
    //MARK: - Poster
    
    static func posterUrl(page: Int) -> String {
        return "https://api.themoviedb.org/3/movie/now_playing\(apiKey)&language=pt-BR&region=BR&page=\(page)"
    }
    
    static func actorDetail(id: Int) -> String {
        "https://api.themoviedb.org/3/person/\(id)\(apiKey)&language=pt-BR"
    }
    
    static func actor(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)/credits\(apiKey)"
    }
    
    static func similarMovies(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)/similar\(apiKey)&language=pt-BR&page=1"
    }
    
    static func movieDetail(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)\(apiKey)&language=pt-BR"
    }
    
    static func actorMovies(id: Int) -> String {
        "https://api.themoviedb.org/3/person/\(id)/credits\(apiKey)&language=pt-BR"
    }
    
    static let apiGenres: String = "https://api.themoviedb.org/3/genre/movie/list\(apiKey)&language=pt-BR"
    
    static func genresMovies(id: Int, page: Int) -> String {
        "https://api.themoviedb.org/3/discover/movie\(apiKey)&language=pt-BR&sort_by=popularity.desc&include_adult=false&page=\(page)&with_genres=\(id)"
    }
    
    static func popularMovies(page: Int) -> String {
        "https://api.themoviedb.org/3/movie/popular\(apiKey)&language=pt-BR&page=\(page)"
    }
    
    static func movieView(movieId: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(movieId)/videos\(apiKey)"
    }
    
    static func getProviders(movieid: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(movieid)/watch/providers\(apiKey)"
    }
    
    static func getActorSocialMedia(actorId: Int) -> String {
        "https://api.themoviedb.org/3/person/\(actorId)/external_ids\(apiKey)"
    }
    
    static func youtubeLink() -> String {
        "https://www.youtube.com/results"
    }
    
    static var facebookLink: String {
        "https://www.facebook.com/"
    }
    
    static var instagramLink: String {
        "https://www.instagram.com/"
    }
    
    static var twitterLink: String {
        "https://twitter.com/"
    }
    
    static func searchMovie(query: String) -> String {
        "https://api.themoviedb.org/3/search/movie\(apiKey)&query=\(query)"
    }
    
    static func getPopularActors(page: Int) -> String {
        "https://api.themoviedb.org/3/trending/person/day\(apiKey)&page=\(String(describing: page))"
    }

    static func getSearchActor(query: String, page: Int) -> String {
        "https://api.themoviedb.org/3/search/person\(apiKey)&query=\(String(describing: query))&page=\(page)"
    }
    
}
