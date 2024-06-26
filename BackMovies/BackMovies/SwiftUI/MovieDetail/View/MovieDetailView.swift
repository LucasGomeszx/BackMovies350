//
//  MovieDetailView.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/06/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject var viewModel: MovieDetailViewModelSwiftUI
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                switch viewModel.satus {
                case .getfetching:
                    ZStack {
                        LottieView(name: "registerLoad", loopMode: .loop)
                            .scaleEffect(0.2)
                            .offset(y: -25)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(Color.backGray)
                case .success:
                    ScrollView {
                        VStack {
                            DetailTopCell(size: geo.size)
                            
                            DetailTrailerCell(size: geo.size)
                            
                            WatchDetailCell(size: geo.size)
                            
                            DetailActorCell(size: geo.size)
                            
                            SimilarMoviesCell(size: geo.size)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        .environmentObject(viewModel)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .padding(.horizontal, -16)
                    .padding(.vertical, -8)
                    .background(Color.backGray)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(.black)
            .onAppear {
                self.viewModel.fetchMovieDetail()
            }
        }
    }
}

#Preview {
    var viewModel = MovieDetailViewModelSwiftUI(movieData: MovieCellModelMock.sampleMovies[0])
    return MovieDetailView(viewModel: viewModel)
}
