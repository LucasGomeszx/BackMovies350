//
//  ActorMoviesTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

protocol ActorMoviesTableViewCellDelegate: AnyObject {
    func navActorMovies(movieId: MovieCellModel)
    func didFetchActorMoviesFailure()
}

enum ActorMoviesSrrings: String {
    case actorMovieTitle = "Conhecido(a) por :"
}

class ActorMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorMoviesTitle: UILabel!
    @IBOutlet weak var actorMoviesCollectionView: UICollectionView!
    
    static let identifier: String = String(describing: ActorMoviesTableViewCell.self)
    
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
    
    public func setUpCell(actorModel: ActorModel) {
        viewModel.setUpViewModel(actorModel: actorModel)
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        actorMoviesTitle.text = ActorMoviesSrrings.actorMovieTitle.rawValue
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
        cell?.setUpCell(data: viewModel.getActorMovies(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navActorMovies(movieId: viewModel.getActorMovies(index: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getActorMoviesCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
