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
            
            ZStack {
                CacheAsyncImage(url: URL(string: Api.posterPath + (movieData.posterPath ?? "")) ?? URL(fileURLWithPath: "")) { image in
                    switch image {
                    case .empty:
                        LottieView(name: "", loopMode: .loop)
                            .scaleEffect(0.15)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 160, height: 260)
                            .scaledToFill()
                    case .failure:
                        Image(.empty)
                            .resizable()
                            .frame(width: 160, height: 260)
                            .scaledToFill()
                    @unknown default:
                        EmptyView()
                            .frame(width: 160, height: 260)
                    }
                }
            }
            .frame(width: 160, height: 260)
            .background(Color.backGray)
            
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
