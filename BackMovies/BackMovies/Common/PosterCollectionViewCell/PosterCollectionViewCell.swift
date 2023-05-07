//
//  PosterCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/03/23.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    static let identifier: String = "PosterCollectionViewCell"
    
    private var viewModel: PosterCollectionViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    //MARK: - SetUps
    
    private func setUpView() {
        mainView.backgroundColor = .black
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        movieNameLabel.textColor = .white
    }
    
    public func setUpCell(movieId: Int) {
        viewModel = PosterCollectionViewModel(movieId: movieId)
        viewModel?.fetchMovieDetail()
        viewModel?.setUpDelegate(delegate: self)
    }
    
}

extension PosterCollectionViewCell: PosterCollectionViewModelDelegate {
    func suss() {
        self.movieNameLabel.text = viewModel?.getMovieDetailName
        guard let image = URL(string: Api.posterPath + (viewModel?.getMovieDetailPoster ?? "")) else {return}
        movieImageView.loadImageFromURL(image)
    }
}
