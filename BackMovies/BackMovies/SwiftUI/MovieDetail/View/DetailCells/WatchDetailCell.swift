//
//  WatchDetailCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/24.
//

import SwiftUI

struct WatchDetailCell: View {
    
    @EnvironmentObject var viewModel: MovieDetailViewModelSwiftUI
    @Environment(\.openURL) var openURL
    var size: CGSize
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Onde assistir?")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.textColor)
                    .padding(.bottom, -10)
                
                ScrollView(.horizontal) {
                    
                    HStack {
                        ForEach(viewModel.movieDetail?.movieProvider?.results?.br?.flatrate ?? [Flatrate()], id: \.logoPath) { image in
                            
                            if !(image.logoPath != nil) {
                                Text("Indisponivel")
                                    .foregroundStyle(Color.textColor)
                            }else {
                                AsyncImage(url: URL(string: Api.posterPath + (image.logoPath ?? ""))) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .scaledToFill()
                                            .clipShape(RoundedRectangle(cornerRadius: 14))
                                    case .failure:
                                        Image(.empty)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .scaledToFill()
                                            .clipShape(RoundedRectangle(cornerRadius: 14))
                                    @unknown default:
                                        EmptyView()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 80)
                
                Text("Que tal videos sobre o filme?")
                    .bold()
                    .foregroundStyle(Color.textColor)
                
                Image(.youtube)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        openURL(viewModel.getUrlYoutube)
                    }
            }
            .padding(.horizontal, 32)
        }
        .border(.red)
        .frame(width: size.width)
    }
}

#Preview {
    var viewModel = MovieDetailViewModelSwiftUI(movieData: MovieCellModelMock.sampleMovies[0])
    var mock = MockMovieDetail.init().movieDetail
    viewModel.movieDetail = mock
    return GeometryReader { geo in
        WatchDetailCell(size: CGSize(width: geo.size.width, height: geo.size.height))
            .environmentObject(viewModel)
    }
}
