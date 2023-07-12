//
//  RetatedTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

protocol RelatedTableViewCellDelegate: AnyObject {
    func navRelatedMovies(movieId: MovieCellModel)
    func didFailToFetchSimilarMovies()
}

enum RelatedStrings: String {
    case relatedLabel = "Filmes Relacionados :"
}

class RelatedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var relatedLabel: UILabel!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    
    static let identifier: String = String(describing: RelatedTableViewCell.self)
    
    let viewModel: RelatedCellViewModel = RelatedCellViewModel()
    weak var delegate: RelatedTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        configCollectionView()
    }
    
    public func setUpCell(id: Int) {
        viewModel.setMovieId(id: id)
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchSimilar()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        relatedLabel.text = RelatedStrings.relatedLabel.rawValue
        relatedLabel.textColor = .white
        relatedCollectionView.backgroundColor = .clear
    }
    
    private func configCollectionView() {
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        if let layout = relatedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        relatedCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }

}

//MARK: - UICollectionView Delegate, DataSource
extension RelatedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getSimilarMoviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        cell?.setUpCell(data: viewModel.getSimilarMovieId(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.navRelatedMovies(movieId: viewModel.getSimilarMovieId(index: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getSimilarMovieCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}

extension RelatedTableViewCell: RelatedCellViewModelDelegate {
    func didFetchSimilarMovies() {
        relatedCollectionView.reloadData()
    }
    
    func didFailToFetchSimilarMovies() {
        delegate?.didFailToFetchSimilarMovies()
    }
    
}
