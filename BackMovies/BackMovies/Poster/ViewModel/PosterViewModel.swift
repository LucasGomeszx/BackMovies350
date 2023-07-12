//
//  PosterViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 12/04/23.
//

import Foundation
import Alamofire

protocol PosterViewModelDelegate: AnyObject {
    func didFetchMovies()
    func didFailToFetchMovies(with error: String)
}

class PosterViewModel {
    
    private weak var delegate: PosterViewModelDelegate?
    private var posterList: MoviesModel?
    private var page: Int = 0
    private var totalPages: Int = 0
    
    func setDelegate(delegate: PosterViewModelDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Getters
    public func getCgSize() -> CGSize {
        return CGSize(width: 140, height: 260)
    }
    
    public func getPoster(index: Int) -> MovieCellModel {
        return posterList?.results?[index] ?? MovieCellModel()
    }
    
    public func getPosterCount() -> Int {
        return posterList?.results?.count ?? 0
    }
    
    //MARK: - FetchMovies
    
    public func fetchMovies() {
        ServiceManeger.shared.fetchMovies { result in
            switch result {
            case .success(let success):
                print(success)
                self.page = success.page ?? 0
                self.totalPages = success.totalPages ?? 0
                self.posterList = success
                self.delegate?.didFetchMovies()
            case .failure(let error):
                self.delegate?.didFailToFetchMovies(with: error.localizedDescription)
            }
        }
    }
    
}
