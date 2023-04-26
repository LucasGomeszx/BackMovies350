//
//  ActorMoviesViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation

protocol ActorMoviesViewModelDelegate: AnyObject {
    func suss()
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
        let net = NetworkRequest(endpointURL: Api.actorMovies(id: actorId ?? 0))
        service.request(net) { (result: Result<ActorMovies, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.actorMovies = success
                    self.delegate?.suss()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
}
