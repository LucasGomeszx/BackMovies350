//
//  SearchSelectedViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

protocol SearchSelectedViewControllerDelegate: NSObject {
    func navMovieDetail()
}

enum SearchSelectedStrings: String {
    case moviesDetail = "MoviesDetailsView"
    case alertError = "Error"
    case moviesError = "Nao foi possível carregar os filmes."
}

class SearchSelectedViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var movieSearch: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    private weak var delegate: SearchSelectedViewControllerDelegate?
    private var viewModel: SearchSelectedViewModel
    
    init?(coder: NSCoder, code: Int, genres: Genre?) {
        viewModel = SearchSelectedViewModel(code: code, genres: genres)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configCollectionView()
        configureView()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchMovies()
    }
    
    private func configCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        if let layout = moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        moviesCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }

    private func configureView() {
        mainView.backgroundColor = .black
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backTappedButton))
        backImage.tintColor = .white
        backImage.addGestureRecognizer(gesture)
        backImage.isUserInteractionEnabled = true
        contentView.backgroundColor = .backGray
        contentView.layer.cornerRadius = 15
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        movieSearch.barTintColor = .backGray
        moviesCollectionView.backgroundColor = .clear
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func backTappedButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UICollectionView Delegate, DataSource
extension SearchSelectedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        cell?.setUpCell(movieId: viewModel.getMoviesId(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: SearchSelectedStrings.moviesDetail.rawValue, bundle: nil).instantiateViewController(identifier: SearchSelectedStrings.moviesDetail.rawValue) { coder -> MovieDetailsViewController? in
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

extension SearchSelectedViewController: SearchSelectedViewModelDelegate {
    func didFetchMoviesSuccess() {
        moviesCollectionView.reloadData()
        titleLabel.text = viewModel.getMainTitleLabel()
    }
    
    func didFetchMoviesFailure() {
        Alert.showAlert(on: self, withTitle: SearchSelectedStrings.alertError.rawValue, message: SearchSelectedStrings.moviesError.rawValue, actions: nil)
    }
}
