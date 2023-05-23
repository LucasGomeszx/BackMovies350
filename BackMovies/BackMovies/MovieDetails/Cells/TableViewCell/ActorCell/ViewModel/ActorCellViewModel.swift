//
//  ActorCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Alamofire

protocol ActorCellViewModelDelegate: AnyObject {
    func didFetchMovies()
    func didFailToFetchMovies(error: String)
}

class ActorCellViewModel {
    
    weak var delegate: ActorCellViewModelDelegate?
    
    private var actor: Elenco?
    private var movieId: Int?
    
    public func setUpViewModel(id: Int) {
        movieId = id
    }
    
    public func getCast(index: Int) -> Cast {
        return actor?.cast?[index] ?? Cast()
    }
    
    public func getCastId(index: Int) -> Int {
        actor?.cast?[index].id ?? 0
    }
    
    var getActorCount: Int {
        actor?.cast?.count ?? 0
    }
    
    var getCellSize: CGSize {
        CGSize(width: 125, height: 275)
    }
    
    public func setUpDelegate(delegate: ActorCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchActors() {
        AF.request(Api.actor(id: movieId ?? 0), method: .get).validate().responseDecodable(of: Elenco.self) { response in
            switch response.result {
            case.success(let result):
                self.actor = result
                self.delegate?.didFetchMovies()
            case .failure(let error):
                self.delegate?.didFailToFetchMovies(error: error.localizedDescription)
            }
        }
    }

}
