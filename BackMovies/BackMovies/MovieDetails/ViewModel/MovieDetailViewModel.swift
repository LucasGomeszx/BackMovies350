//
//  MovieDetailViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/04/23.
//

import Foundation
import Alamofire

protocol MovieDetailViewModelDelegate: AnyObject {
    func fetchMovieDetailSuccess()
    func fetchMovieDetailFailure(error: String)
}

class MovieDetailViewModel {
    
    private var movieId: MovieCellModel
    private var movieDetail: MovieDetail?
    private weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieId: MovieCellModel){
        self.movieId  = movieId
    }
    
    public func setUpDelegate(delegate: MovieDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchMovieDetail() {
        ServiceManeger.shared.fetchMovieDetail(movieId: movieId.id ?? 0) { result in
            switch result {
            case .success(let success):
                self.movieDetail = success
                self.delegate?.fetchMovieDetailSuccess()
            case .failure(let error):
                self.delegate?.fetchMovieDetailFailure(error: error.localizedDescription)
            }
        }
    }
    
    var getMovieName: String {
        movieDetail?.title ?? ""
    }
    
    var getTableViewCellCount: Int {
        6
    }
    
    var getMovieTopCellSize: CGFloat {
        640
    }
    
    func getTrailerCellSize(width: CGFloat) -> CGFloat {
        let text = movieDetail?.overview ?? ""
        let font = UIFont.systemFont(ofSize: 14)
        let estimateHeight = text.heightWithConstrainedWidth(width: width, font: font)
        return estimateHeight + 380
    }
    
    var getWatchCellSize: CGFloat {
        250
    }
    
    var getActorCellSize: CGFloat {
        300
    }
    
    var getRelatedCell: CGFloat {
        340
    }
    
    var getMapCellSize: CGFloat {
        250
    }
    
    var getMovieDetail: MovieDetail {
        movieDetail ?? MovieDetail()
    }
    
    var getMovieId: Int {
        movieId.id ?? 0
    }
    
    func searchMovieOnYouTube() {
        let movieName = getMovieName
        let baseURLString = Api.youtubeLink()
        let query = movieName.replacingOccurrences(of: " ", with: "+")
        
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "\(baseURLString)?search_query=\(encodedQuery)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
