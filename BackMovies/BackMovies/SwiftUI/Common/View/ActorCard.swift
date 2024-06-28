//
//  ActorCard.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 25/06/24.
//

import SwiftUI

struct ActorCard: View {
    
    var movieCast: Cast
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                CacheAsyncImage(url: URL(string: Api.posterPath + (movieCast.profilePath ?? "")) ?? URL(fileURLWithPath: "")) { phase in
                    switch phase {
                    case .empty:
                        LottieView(name: "", loopMode: .loop)
                            .scaleEffect(0.15)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 160, height: 240)
                            .scaledToFill()
                    case .failure:
                        Image(.empty)
                            .resizable()
                            .frame(width: 160, height: 240)
                            .scaledToFill()
                    @unknown default:
                        EmptyView()
                            .frame(width: 160, height: 240)
                    }
                }
                
                Text(movieCast.name ?? "")
                    .foregroundStyle(Color.textColor)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .bold()
                    .padding(.horizontal)
                
                Text(movieCast.character ?? "")
                    .foregroundStyle(Color.textColor)
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
        .frame(width: 160, height: 300)
        .background(.black)
        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }
}

#Preview {
    var mock = ActorCellMock.CastModel
    return ActorCard(movieCast: mock)
}
