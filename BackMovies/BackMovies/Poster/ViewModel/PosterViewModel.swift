//
//  PosterViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 12/04/23.
//

import Foundation

protocol PosterViewModelDelegate: AnyObject {
    func success()
    func failure()
}

class PosterViewModel {
    
    weak var delegate: PosterViewModelDelegate?
    private let service: Service = Service()
    private var posterList: Movies?
    
    func setDelegate(delegate: PosterViewModelDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Getters
    
    public func getCgSize() -> CGSize {
        return CGSize(width: 140, height: 260)
    }
    
    public func getPoster(index: Int) -> Poster {
       return posterList?.results?[index] ?? Poster()
    }
    
    public func getPosterCount() -> Int {
        return posterList?.results?.count ?? 0
    }
    
    //MARK: - FetchMovies
    
    public func fetchMovies() {
        let net = NetworkRequest(endpointURL: Api.posterUrl())
        
        service.request(net) { (result: Result<Movies, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.posterList = success
                    self.delegate?.success()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self.delegate?.failure()
                }
            }
        }
    }
    
}
