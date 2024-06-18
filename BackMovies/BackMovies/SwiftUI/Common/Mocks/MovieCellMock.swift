//
//  MovieCellMock.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 18/06/24.
//

import Foundation

import Foundation

class MovieCellModelMock {
    static let sampleMovies: [MovieCellModel] = [
        MovieCellModel(
            id: 1,
            overview: "An epic adventure of a hobbit named Frodo who embarks on a quest to destroy the One Ring.",
            posterPath: "/poster1.jpg",
            title: "The Lord of the Rings: The Fellowship of the Ring",
            voteAverage: 8.8
        ),
        MovieCellModel(
            id: 2,
            overview: "A group of friends navigate the ups and downs of high school life.",
            posterPath: "/poster2.jpg",
            title: "High School Musical",
            voteAverage: 6.4
        ),
        MovieCellModel(
            id: 3,
            overview: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
            posterPath: "/poster3.jpg",
            title: "The Godfather",
            voteAverage: 9.2
        ),
        MovieCellModel(
            id: 4,
            overview: "In a post-apocalyptic wasteland, Max teams up with Furiosa to flee from a cult leader and his army.",
            posterPath: "/poster4.jpg",
            title: "Mad Max: Fury Road",
            voteAverage: 8.1
        )
    ]
}
