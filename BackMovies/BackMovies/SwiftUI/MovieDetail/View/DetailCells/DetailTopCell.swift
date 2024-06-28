//
//  DetailTopCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 20/06/24.
//

import SwiftUI

struct DetailTopCell: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MovieDetailViewModelSwiftUI
    
    var size: CGSize
    
    var body: some View {
        VStack {
            
            HStack {
                ZStack(alignment: .leading) {
                    
                    Text("Detalhes")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: size.width)
                        .padding(.horizontal, -32)
                    
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 25, height: 25)
                    }
                }
                .padding()
            }
            
            ZStack {
                CacheAsyncImage(url: URL(string: Api.posterPath + (viewModel.movieData.posterPath ?? "")) ?? URL(fileURLWithPath: "")) { image in
                    switch image {
                    case .empty:
                        ProgressView()
                            .frame(width: size.width, height: 450)
                            .padding(.horizontal, -32)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: size.width - 64, height: 450)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    case .failure:
                        Image(.empty)
                            .resizable()
                            .frame(width: size.width, height: 450)
                            .padding(.horizontal, -32)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .border(.red)
                    @unknown default:
                        EmptyView()
                            .frame(width: size.width - 64, height: 450)
                    }
                }
            }
            .background(Color.backGray)
            .frame(width: size.width - 64, height: 450)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Text(viewModel.movieData.title ?? "")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .padding()
            
            HStack{
                
                HStack{
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 25)
                    
                    Text("7.9")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Button {
                    viewModel.tappedHeartImage()
                } label: {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                }
                
            }
            .padding(.horizontal, 16)
            
            Divider()
                .frame(height: 2)
                .background(Color.lineGray)
            
            Spacer()
            
        }
        .padding(.horizontal, 32)
        .frame(width: size.width)
    }
}

#Preview {
    var viewModel = MovieDetailViewModelSwiftUI(movieData: MovieCellModelMock.sampleMovies[0])
    return GeometryReader { geo in
        DetailTopCell(size: CGSize(width: geo.size.width, height: geo.size.height))
            .environmentObject(viewModel)
    }
}
