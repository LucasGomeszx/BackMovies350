//
//  SimilarMoviesCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 25/06/24.
//

import SwiftUI

struct SimilarMoviesCell: View {
    
    @EnvironmentObject var viewModel: MovieDetailViewModelSwiftUI
    var size: CGSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Filmes Relacionados:")
                .font(.title3)
                .bold()
                .foregroundStyle(Color.textColor)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.similarMovies?.results ?? [MovieCellModel()], id: \.id) { movie in
                        MovieCard(movieData: movie)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .frame(height: 320)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(width: size.width - 32)
    }
}

#Preview {
    var viewModel = MovieDetailViewModelSwiftUI(movieData: MovieCellModelMock.sampleMovies.first ?? MovieCellModel())
    return GeometryReader { geo in
        SimilarMoviesCell(size: CGSize(width: geo.size.width, height: geo.size.height))
            .environmentObject(viewModel)
    }
}
