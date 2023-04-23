//
//  RetatedTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

protocol RetatedTableViewCellDelegate: AnyObject {
    func navRelatedMovies(movie: Poster)
}

class RetatedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var relatedLabel: UILabel!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    
    static let identifier: String = String(describing: RetatedTableViewCell.self)
    
    let viewModel: RelatedCellViewModel = RelatedCellViewModel()
    weak var delegate: RetatedTableViewCellDelegate?
    
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
        relatedLabel.text = "Filmes Relacionados :"
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
extension RetatedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        cell?.setUpCell(movies: viewModel.getSimilarMovie(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navRelatedMovies(movie: self.viewModel.getSimilarMovie(index: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}

extension RetatedTableViewCell: RelatedCellViewModelDelegate {
    func didFetchMovies() {
        relatedCollectionView.reloadData()
    }
    
    func didFailToFetchMovies(with error: String) {
        print(error)
    }
    
}
