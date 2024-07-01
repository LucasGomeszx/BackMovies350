//
//  SwiftUIServiceManeger.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 28/06/24.
//

import Foundation

class SwiftUIServiceManeger {
    
    static let shered: SwiftUIServiceManeger = SwiftUIServiceManeger()
    private var service: Service = Service()
    
    public func fetchMovies() async throws -> MoviesModel {
        do {
            let movies: MoviesModel = try await service.request(Api.posterUrl(page: 1))
            return movies
        } catch {
            throw error
        }
    }
    
    //MARK: - MovieDetail
    
    public func fetchMovieVideo(movieId: Int) async throws -> Video {
        do {
            let data: Video = try await service.request(Api.movieView(movieId: movieId))
            return data
        } catch {
            throw error
        }
    }
    
    public func fetchWatchProviders(movieId: Int) async throws -> WatchProviders {
        do {
            let data: WatchProviders = try await service.request(Api.getProviders(movieid: movieId))
            return data
        } catch {
            throw error
        }
    }
    
    public func fetchActors(movieId: Int) async throws -> CastModel {
        do {
            let data: CastModel = try await service.request(Api.actor(id: movieId))
            return data
        } catch {
            throw error
        }
    }
    
    public func fetchSimilarMovies(movieId: Int) async throws -> MoviesModel{
        do {
            let data: MoviesModel = try await service.request(Api.similarMovies(id: movieId))
            return data
        } catch {
            throw error
        }
    }
    
}
