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
    
    private var movieId: Int
    private var service: Service = Service()
    private var movieDetail: MovieDetail?
    private weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieId: Int){
        self.movieId  = movieId
    }
    
    public func setUpDelegate(delegate: MovieDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchMovieDetail() {
        AF.request(Api.movieDetail(id: movieId), method: .get).validate().responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case.success(let result):
                self.movieDetail = result
                self.delegate?.fetchMovieDetailSuccess()
            case .failure(let error):
                self.delegate?.fetchMovieDetailFailure(error: error.localizedDescription)
            }
        }
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
        return estimateHeight + 330
    }
    
    var getWatchCellSize: CGFloat {
        220
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
        movieId
    }
    
}
