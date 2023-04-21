//
//  PosterViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class PosterViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    //MARK: - LifeCycle
    
    var viewModel: PosterViewModel = PosterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setDelegate(delegate: self)
        configCollectionView()
        configureNavigation()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchMovies()
    }
    
    //MARK: - SetUps
    
    private func setUpView() {
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
        posterCollectionView.backgroundColor = UIColor(named: "BackGray")
        posterCollectionView.layer.cornerRadius = 15
    }
    
    private func configCollectionView() {
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        if let layout = posterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        posterCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
    
    //MARK: - Navigation
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }
}

    //MARK: - UICollectionView Delegate, DataSource

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPosterCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        cell?.setUpCell(movies: viewModel.getPoster(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: "MoviesDetailsView", bundle: nil).instantiateViewController(identifier: "MoviesDetailsView") { coder -> MovieDetailsViewController? in
            return MovieDetailsViewController(coder: coder, poster: self.viewModel.getPoster(index: indexPath.row))
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCgSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
    }
    
}

    //MARK: - PosterViewModelDelegate

extension PosterViewController: PosterViewModelDelegate {
    func didFetchMovies() {
        posterCollectionView.reloadData()
    }
    
    func didFailToFetchMovies(with error: String) {
        Alert.showAlert(on: self, withTitle: "Error", message: error, actions: nil)
    }
    
}
