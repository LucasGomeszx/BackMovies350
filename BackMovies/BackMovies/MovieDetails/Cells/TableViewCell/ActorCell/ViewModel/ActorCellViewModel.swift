//
//  ActorCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

protocol ActorCellViewModelDelegate: AnyObject {
    func didFetchMovies()
    func didFailToFetchMovies(with error: String)
}

class ActorCellViewModel {
    
    weak var delegate: ActorCellViewModelDelegate?
    
    private let service: Service = Service()
    private var actor: Elenco?
    private var movieId: Int?
    
    public func setUpViewModel(id: Int) {
        movieId = id
    }
    
    var getActorCount: Int {
        actor?.cast.count ?? 0
    }
    
    var getCellSize: CGSize {
        CGSize(width: 125, height: 225)
    }
    
    public func setUpDelegate(delegate: ActorCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchActors() {
        let url = NetworkRequest(endpointURL: Api.actor(id: movieId ?? 0))
        print(url)
        service.request(url) { (result :Result<Elenco, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.actor = success
                    self.delegate?.didFetchMovies()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self.delegate?.didFailToFetchMovies(with: error.localizedDescription)
                }
            }
        }
            
    }
    
}
