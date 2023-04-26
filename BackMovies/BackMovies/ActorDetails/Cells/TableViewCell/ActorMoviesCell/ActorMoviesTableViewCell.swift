//
//  ActorMoviesTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

protocol ActorMoviesTableViewCellDelegate: AnyObject {
    func navActorMovies(movieId: Int)
}

class ActorMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorMoviesTitle: UILabel!
    @IBOutlet weak var actorMoviesCollectionView: UICollectionView!
    
    static let identifier: String = "ActorMoviesTableViewCell"
    
    weak var delegate: ActorMoviesTableViewCellDelegate?
    var viewModel: ActorMoviesViewModel = ActorMoviesViewModel()
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        configureCollectionView()
    }
    
    public func setUpCell(actorId: Int) {
        viewModel.setUpViewModel(actorId: actorId)
        viewModel.serUpDelegate(delegate: self)
        viewModel.fetchActorMovies()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        actorMoviesTitle.text = "Conhecido(a) por :"
        actorMoviesTitle.textColor = .white
        actorMoviesCollectionView.backgroundColor = .clear
    }
    
    private func configureCollectionView() {
        actorMoviesCollectionView.delegate = self
        actorMoviesCollectionView.dataSource = self
        if let layout = actorMoviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        actorMoviesCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }

}

//MARK: - UICollectionView Delegate, DataSource

extension ActorMoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getActorMoviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        cell?.setUpCell(movieId: viewModel.getActorMoviesId(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navActorMovies(movieId: viewModel.getActorMoviesId(index: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getActorMoviesCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}

extension ActorMoviesTableViewCell: ActorMoviesViewModelDelegate {
    func suss() {
        actorMoviesCollectionView.reloadData()
    }
}
