//
//  DetailTrailerCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/24.
//

import SwiftUI
import youtube_ios_player_helper

struct DetailTrailerCell: View {
    
    @EnvironmentObject var viewModel: MovieDetailViewModelSwiftUI
    var size: CGSize
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Treiler")
                    .foregroundStyle(Color.textColor)
                    .font(.system(size: 18))
                    .bold()
                    .padding(.horizontal, 16)
                
                Spacer()
            }
            .frame(width: size.width - 32)
            
            
            YTWrapper(videoID: viewModel.getMovieVideoKey)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .frame(width: size.width - 64, height: 250)
            
            VStack(alignment: .leading) {
                Text("Sinopse:")
                    .foregroundStyle(Color.textColor)
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 2)
                    .padding(.horizontal, 16)
                
                Text(viewModel.movieData.overview ?? "Indisponivel")
                    .foregroundStyle(Color.textColor)
                    .font(.system(size: 16))
                    .bold()
                    .padding(.horizontal, 16)
            }
            
            Spacer()
            
        }
        .padding(.horizontal, 32)
        .frame(width: size.width)
    }
}

struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        //
    }
}

#Preview {
    var viewModel = MovieDetailViewModelSwiftUI(movieData: MovieCellModelMock.sampleMovies[0])
    var mock = MockMovieDetail.init().movieDetail
    viewModel.movieVideo = mock.movieVideo
    return GeometryReader { geo in
        DetailTrailerCell(size: CGSize(width: geo.size.width, height: geo.size.height))
            .environmentObject(viewModel)
    }
}
