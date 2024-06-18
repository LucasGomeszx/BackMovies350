//
//  MovieCard.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 18/06/24.
//

import SwiftUI

struct MovieCard: View {
    
    @State var movieData: MovieCellModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: Api.posterPath + (movieData.posterPath ?? ""))) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 160, height: 260)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 260)
                        .clipped()
                case .failure:
                    Image(.empty)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 260)
                        .background(Color.gray.opacity(0.3))
                @unknown default:
                    EmptyView()
                        .frame(width: 160, height: 260)
                }
            }
            
            Spacer()
            
            Text(movieData.title ?? "Unknown Title")
                .foregroundColor(.white)
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 150)
        }
        .frame(width: 160, height: 300)
        .padding(.bottom, 20)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    @State var movieCellMock = MovieCellModelMock.sampleMovies
    
    return MovieCard(movieData: movieCellMock.first ?? MovieCellModel())
}
