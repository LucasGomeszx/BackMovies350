//
//  FavoriteViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

enum FavoriteStrings: String {
    case moviesDetail = "MoviesDetailsView"
    case alertError = "Error"
    case moviesError = "Não foi possível carregar os filmes."
}

class FavoriteViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var viewModel: FavoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
        configCollectionView()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchMovies()
    }
    
    private func configCollectionView() {
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        if let layout = favoriteCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        favoriteCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }

    private func configureView() {
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
        favoriteCollectionView.backgroundColor = .backGray
        favoriteCollectionView.layer.cornerRadius = 15
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }

}

//MARK: - UICollectionView Delegate, DataSource

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        cell?.setUpCell(movieId: viewModel.getMoviesId(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: FavoriteStrings.moviesDetail.rawValue, bundle: nil).instantiateViewController(identifier: FavoriteStrings.moviesDetail.rawValue) { coder -> MovieDetailsViewController? in
            return MovieDetailsViewController(coder: coder, movieId: self.viewModel.getMoviesId(index: indexPath.row))
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getMovieCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
    }
    
}

//MARK: - FavoriteViewModelDelegate

extension FavoriteViewController: FavoriteViewModelDelegate {
    func didFetchMoviesSuccess() {
        favoriteCollectionView.reloadData()
    }
    
    func didFetchMoviesFailure() {
        Alert.showAlert(on: self, withTitle: FavoriteStrings.alertError.rawValue, message: FavoriteStrings.moviesError.rawValue, actions: nil)
    }
}
