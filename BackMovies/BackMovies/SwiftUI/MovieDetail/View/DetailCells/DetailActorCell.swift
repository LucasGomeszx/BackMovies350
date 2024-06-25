//
//  DetailActorCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 25/06/24.
//

import SwiftUI

struct DetailActorCell: View {
    
    @EnvironmentObject var viewModel: MovieDetailViewModelSwiftUI
    var size: CGSize
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Divider()
                    .frame(height: 2)
                    .background(Color.lineGray)
                    .padding(.top, 4)
                
                Text("Elenco:")
                    .padding(.horizontal, 3)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.textColor)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.movieDetail?.movieCast?.cast ?? [Cast()], id: \.id) { cast in
                            ActorCard(movieCast: cast)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(height: 320)
                
            }
            .padding(.horizontal, 16)
        }
        .frame(width: size.width - 32)
    }
}

#Preview {
    var viewModel = MovieDetailViewModelSwiftUI(movieData: MovieCellModelMock.sampleMovies[0])
    
    return GeometryReader { geo in
        DetailActorCell(size: CGSize(width: geo.size.width, height: geo.size.height))
            .environmentObject(viewModel)
    }
    
    
}
