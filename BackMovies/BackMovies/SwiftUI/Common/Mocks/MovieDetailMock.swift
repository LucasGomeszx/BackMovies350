//
//  MovieDetailMock.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 25/06/24.
//

import Foundation

struct MockMovieDetail {
    let movieDetail: MovieDetailModel = MovieDetailModel(
        movieCellModel: MovieCellModel(
            id: 1022789,
            overview: "Divertida Mente 2, da Disney e Pixar, volta a entrar na mente da agora adolescente Riley, no momento em que a Sala de Comando passa por uma repentina demolição para dar lugar a algo totalmente inesperado: novas Emoções. Alegria, Tristeza, Raiva, Medo e Nojinho, que há muito tempo comandam uma operação de sucesso, não sabem ao certo como se sentem quando a Ansiedade, a Inveja, o Tédio e a Vergonha chegam.",
            posterPath: "/9h2KgGXSmWigNTn3kQdEFFngj9i.jpg",
            title: "Divertida Mente 2",
            voteAverage: 8.8
        ),
        movieVideo: Video(results: [
            VideoKey(key: "RY5aH21ohU4", type: "Teaser"),
            VideoKey(key: "eioXDOSx6rQ", type: "Teaser"),
            VideoKey(key: "kXEClscNx8Y", type: "Teaser"),
            VideoKey(key: "vh2JuW2tu1I", type: "Trailer"),
            VideoKey(key: "ax_HyltjcBw", type: "Trailer"),
            VideoKey(key: "8Zvkdc3c5Y0", type: "Trailer"),
            VideoKey(key: "J3GZ2EZ9mkk", type: "Trailer"),
            VideoKey(key: "Urs19jWqBv8", type: "Trailer"),
            VideoKey(key: "8gd_ohoPzYc", type: "Trailer")
        ]),
        movieProvider: WatchProviders(id: 1022789, results: Country(br: nil)),
        movieCast: CastModel(id: 1022789, cast: [
            Cast(id: 56322, name: "Amy Poehler", profilePath: "/rwmvRonpluV6dCPiQissYrchvSD.jpg", character: "Joy (voice)"),
            Cast(id: 1903874, name: "Maya Hawke", profilePath: "/evjbbHM1bzA6Ma5Ptjwa4WkYkkj.jpg", character: "Anxiety (voice)"),
            Cast(id: 3896, name: "Phyllis Smith", profilePath: "/4B1IkHZ93Le0OWPHUDeMwoVcH8A.jpg", character: "Sadness (voice)"),
            Cast(id: 51630, name: "Bill Hader", profilePath: "/2gOdETlboHbTFQ3pImCxwQLOUiv.jpg", character: "Fear (voice)"),
            Cast(id: 145464, name: "Louis Black", profilePath: "/mPEN9KpJTkDdo5R8rGL5YTTQR0M.jpg", character: "Anger (voice)"),
            Cast(id: 1632568, name: "Vivian Nixon", profilePath: "/mBIdNqqVz61mDJYtybOZsNfD30y.jpg", character: "Nervous (voice)"),
            Cast(id: 2453307, name: "Diane Lane", profilePath: "/y3vGuux8qlY1hBZqE1FBpPa3PqV.jpg", character: "Grace (voice)"),
            Cast(id: 2354692, name: "Cooper Raiff", profilePath: "/gj5DNGWAH8Z9uQ7oyqyIRlZpxdf.jpg", character: "John (voice)"),
            Cast(id: 2098797, name: "Emmy Raver-Lampman", profilePath: "/1oWTiJ9gAUKKhKiaypIjPXiObPH.jpg", character: "Secret (voice)"),
            Cast(id: 2056818, name: "Lilly Collins", profilePath: "/3U2RCE9fttxojntqEhrC0ITsU38.jpg", character: "Glare (voice)"),
            Cast(id: 1213276, name: "Pete Docter", profilePath: "/tnFyqaF6iiePXVt5LCANZV0EOC2.jpg", character: "The Forgetters (voice)")
        ]),
        similarMovies: MoviesModel(page: 1, results: [
            MovieCellModel(id: 20766, overview: "O mundo foi destruído há mais de 10 anos e desde então, o que resta da humanidade se transforma em canibais. Uma das poucas exceções é um homem...", posterPath: "/6pm9nlQoGx8egjJx85NTgiOSLYG.jpg", title: "A Estrada", voteAverage: 7.005),
            MovieCellModel(id: 682261, overview: "Sam é um detetive decadente, obcecado...", posterPath: "/wLwloWMwiGEi0EjiZ3VDE6RlgwB.jpg", title: "Sam's Town", voteAverage: 6.8),
            MovieCellModel(id: 766, overview: "Em uma ilha isolada, cientistas...", posterPath: "/2uEVkw9pWE9U3VciXbP5VkjQ3qt.jpg", title: "The Island", voteAverage: 6.9)
        ])
    )
}
