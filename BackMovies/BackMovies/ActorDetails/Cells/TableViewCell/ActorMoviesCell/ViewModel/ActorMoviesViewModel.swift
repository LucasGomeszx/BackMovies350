//
//  ActorMoviesViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation
import Alamofire

protocol ActorMoviesViewModelDelegate: AnyObject {
    func didFetchActorMoviesSucess()
    func didFetchActorMoviesFailure()
}

class ActorMoviesViewModel {
    
    private var actorId: Int?
    private var actorMovies: ActorMovies?
    private var service: Service = Service()
    private weak var delegate: ActorMoviesViewModelDelegate?
    
    public func setUpViewModel(actorId: Int) {
        self.actorId = actorId
    }
    
    public func serUpDelegate(delegate: ActorMoviesViewModelDelegate) {
        self.delegate = delegate
    }
    
    var getActorMoviesCount: Int {
        actorMovies?.cast?.count ?? 0
    }
    
    public func getActorMoviesId(index: Int) -> Int {
        actorMovies?.cast?[index].id ?? 0
    }
    
    var getActorMoviesCellSize: CGSize {
        CGSize(width: 140, height: 260)
    }
    
    public func fetchActorMovies() {
        AF.request(Api.actorMovies(id: actorId ?? 0), method: .get).validate().responseDecodable(of: ActorMovies.self) { response in
            switch response.result {
            case .success(let result):
                self.actorMovies = result
                self.delegate?.didFetchActorMoviesSucess()
            case .failure(_):
                self.delegate?.didFetchActorMoviesFailure()
            }
        }
    }
    
}
