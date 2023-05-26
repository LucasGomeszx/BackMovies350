//
//  ActorDetailsViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 23/04/23.
//

import Foundation
import Alamofire

protocol ActorDetailsViewModelDelegate: AnyObject {
    func didFetchActor()
    func didFailToFetchActor()
}

class ActorDetailsViewModel {
    
    private var actorId: Int
    private var actorModel: ActorModel?
    private weak var delegate: ActorDetailsViewModelDelegate?
    
    init(actorId: Int) {
        self.actorId = actorId
    }

    public func fetchActor() {
        AF.request(Api.actorDetail(id: actorId), method: .get).validate().responseDecodable(of: ActorModel.self) { response in
            switch response.result {
            case .success(let result):
                self.actorModel = result
                self.delegate?.didFetchActor()
            case .failure(_):
                self.delegate?.didFailToFetchActor()
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
