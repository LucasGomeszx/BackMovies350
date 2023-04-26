//
//  ActorDetailsViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 23/04/23.
//

import Foundation

protocol ActorDetailsViewModelDelegate: AnyObject {
    func didFetchActor()
    func didFailToFetchActor()
}

class ActorDetailsViewModel {
    
    private var actorId: Int
    private var actorModel: ActorModel?
    private let service: Service = Service()
    
    init(actorId: Int) {
        self.actorId = actorId
    }
    
    private var delegate: ActorDetailsViewModelDelegate?

    public func fetchActor() {
        
        let url = NetworkRequest(endpointURL: Api.actorDetail(id: actorId))
        service.request(url) { (result :Result<ActorModel, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.actorModel = success
                    self.delegate?.didFetchActor()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure.localizedDescription)
                }
            }
        }
        
    }
    
    public func setUpDelegate(delegate: ActorDetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    var getActorDetail: ActorModel {
        actorModel ?? ActorModel()
    }
    
    var getActorId: Int {
        actorId
    }
    
    var getTableViewCellCount: Int {
        3
    }
    
    var getActorTopCell: CGFloat {
        780
    }
    
    var getActorInfoCell: CGFloat {
        220
    }
    
    var getActorMoviesCell: CGFloat {
        340
    }
    
}
