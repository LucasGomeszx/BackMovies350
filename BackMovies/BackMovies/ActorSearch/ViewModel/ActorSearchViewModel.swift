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
    
    func fetchPopularActor() {
        actorList = []
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
    
    func searchQuaryActor(query: String) {
        self.actorList = []
        AF.request(Api.getSearchActor(query: query), method: .get).validate().responseDecodable(of: ActorSearch.self) { response in
            switch response.result {
            case .success(let result):
                self.actorList = result.results ?? [ActorInfo()]
                self.delegate?.didFetchActorSuccess()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func searchActor(query: String) {
        if !query.isEmpty {
            let encodedString = query.replacingOccurrences(of: " ", with: "%20")
            searchQuaryActor(query: encodedString)
        }else {
            fetchPopularActor()
        }
    }
    
    public func getActorId(index: Int) -> Int {
        actorList[index].id ?? 0
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
