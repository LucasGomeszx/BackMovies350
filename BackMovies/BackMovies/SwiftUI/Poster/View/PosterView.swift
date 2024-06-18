//
//  PosterView.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 11/06/24.
//

import SwiftUI

struct PosterView: View {
    
    @StateObject var viewModel: PosterViewModelSwiftUI = PosterViewModelSwiftUI()
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    VStack {
                        Text("Cinema")
                            .font(.title)
                            .bold()
                            .padding(.top, 25)
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(viewModel.posterList.results ?? []) { poster in
                                    MovieCard(movieData: poster)
                                }
                            }
                        }
                        .padding(.vertical)
                        .frame(width: geo.size.width - 32, height: geo.size.height - 64)
                        .scrollIndicators(.hidden)
                        
                        Spacer()
                    }
                    .frame(width:geo.size.width - 32, height: geo.size.height)
                    .background(Color.backGray)
                    .clipShape(RoundedRectangle(cornerRadius: 26.0))
                }
                .onAppear(perform: {
                    viewModel.fetchMovies()
                })
                .frame(width:geo.size.width, height: geo.size.height)
            }
        }
    }
    
}

#Preview {
    PosterView()
}
