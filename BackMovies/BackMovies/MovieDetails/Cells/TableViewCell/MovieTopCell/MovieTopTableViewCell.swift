//
//  MovieTopTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

class MovieTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRateLebel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    static let identifier: String = String(describing: MovieTopTableViewCell.self)
    
    var viewModel: MovieTopCellViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public func setUpCell(poster: Poster) {
        viewModel = MovieTopCellViewModel(movie: poster)
        guard let url = URL(string: Api.posterPath + (viewModel?.posterPath ?? "") ) else {return}
        posterImageView.loadImageFromURL(url)
        movieNameLabel.text = viewModel?.title
        movieRateLebel.text = viewModel?.voteAvg
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
        movieNameLabel.textColor = .white
        starImageView.image = UIImage(systemName: "star")
        starImageView.tintColor = .white
        movieRateLebel.textColor = .white
        heartImageView.image = UIImage(systemName: "heart")
        heartImageView.tintColor = .white
    }
    
}
