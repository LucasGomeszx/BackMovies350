//
//  MovieTopTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit
import Lottie

enum MovieTopStrings: String {
    case loafImage = "imageLoad"
    case starImage = "star"
    case heartImage = "heart"
}

class MovieTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRateLebel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    let lottieAnimation: LottieAnimationView = LottieAnimationView(name: MovieTopStrings.loafImage.rawValue)
    
    static let identifier: String = String(describing: MovieTopTableViewCell.self)
    private var viewModel: MovieTopCellViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public func setUpCell(movieDetail: MovieDetail) {
        viewModel = MovieTopCellViewModel(movieDetail: movieDetail)
        setupLottieView()
        guard let url = URL(string: Api.posterPath + (viewModel?.posterPath ?? "") ) else {return}
        posterImageView.loadImageFromURL(url) { result in
            switch result {
            case .success(let image):
                self.stopLottieView()
                self.posterImageView.image = image
            case .failure(_):
                self.stopLottieView()
            }
        }
        movieNameLabel.text = viewModel?.title
        movieRateLebel.text = viewModel?.voteAvg
    }
    
    private func setupLottieView() {
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.addSubview(lottieAnimation)
        NSLayoutConstraint.activate([
            lottieAnimation.widthAnchor.constraint(equalToConstant: 75),
            lottieAnimation.heightAnchor.constraint(equalToConstant: 75),
            lottieAnimation.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            lottieAnimation.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor)
        ])
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()
    }
    
    private func stopLottieView() {
        lottieAnimation.stop()
        lottieAnimation.removeFromSuperview()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
        movieNameLabel.textColor = .white
        movieNameLabel.numberOfLines = 0
        movieNameLabel.textAlignment = .center
        starImageView.image = UIImage(systemName: MovieTopStrings.starImage.rawValue)
        starImageView.tintColor = .white
        movieRateLebel.textColor = .white
        heartImageView.image = UIImage(systemName: MovieTopStrings.heartImage.rawValue)
        heartImageView.tintColor = .white
    }
    
}
