//
//  ActorSearchViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/23.
//

import Foundation
import Alamofire

protocol ActorSearchViewModelProtocol: AnyObject {
    func didFetchActorSuccess()
}

class ActorSearchViewModel {
    
    private var actorSearch: ActorSearch?
    private var actorList: [ActorInfo] = []
    private var page: Int = 1
    private var totalPage: Int = 1
    private weak var delegate: ActorSearchViewModelProtocol?
    
    func fetchActor() {
        AF.request(Api.getPopularActors(page: page), method: .get).validate().responseDecodable(of: ActorSearch.self) { response in
            switch response.result {
            case .success(let result):
                self.actorSearch = result
                self.actorList += result.results ?? [ActorInfo()]
                self.page = result.page ?? 0
                self.totalPage = result.totalPages ?? 0
                self.delegate?.didFetchActorSuccess()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchActor(query: String) {
        
    }
    
    func setupDelegate(delegate: ActorSearchViewModelProtocol) {
        self.delegate = delegate
    }
    
    var getActorCellSize: CGSize {
        CGSize(width: 135, height: 260)
    }
    
    var getActorCount: Int {
        self.actorList.count
    }
    
    func getActorInfo(index: Int) -> ActorInfo {
        self.actorList[index]
    }
    
}
