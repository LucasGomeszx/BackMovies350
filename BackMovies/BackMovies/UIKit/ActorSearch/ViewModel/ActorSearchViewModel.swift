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
    private var query: String = ""
    private weak var delegate: ActorSearchViewModelProtocol?
    
    public func fetchPopularActor() {
        actorList.removeAll()
        page = 1
        ServiceManeger.shared.fetchPopularActor(page: page) { result in
            switch result {
            case .success(let success):
                self.actorSearch = success
                self.actorList = success.results ?? [ActorInfo()]
                self.page = success.page ?? 0
                self.totalPage = success.totalPages ?? 0
                self.delegate?.didFetchActorSuccess()
            case .failure(_):
                break
            }
        }
    }
    
    public func getMorePopularActor() {
        if page < totalPage {
            page += 1
            ServiceManeger.shared.getMorePopulatActor(page: page) { result in
                switch result {
                case .success(let success):
                    self.actorList += success.results ?? [ActorInfo()]
                    self.delegate?.didFetchActorSuccess()
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func searchQuaryActor(query: String) {
        actorList.removeAll()
        page = 1
        ServiceManeger.shared.searchQuaryActor(query: query, page: page) { result in
            switch result {
            case .success(let success):
                self.actorSearch = success
                self.actorList = success.results ?? [ActorInfo()]
                self.page = success.page ?? 0
                self.totalPage = success.totalPages ?? 0
                self.delegate?.didFetchActorSuccess()
            case .failure(_):
                break
            }
        }
    }
    
    public func getMoreActors() {
        if query.isEmpty {
            self.getMorePopularActor()
        }
    }
    
    public func searchActor(query: String) {
        self.query = query
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
