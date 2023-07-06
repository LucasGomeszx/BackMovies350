//
//  PosterCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/03/23.
//

import UIKit
import Lottie

class PosterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: PosterCollectionViewCell.self)
    private var viewModel: PosterCollectionViewModel?
    private let lottieAnimation: LottieAnimationView = LottieAnimationView(name: "imageLoad")
    
    // MARK: - Nib
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    // MARK: - Setups
    
    private func setUpView() {
        mainView.backgroundColor = .black
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        movieNameLabel.textColor = .white
    }
    
    // MARK: - Public Methods
    
    public func setUpCell(movieId: Int) {
        viewModel = PosterCollectionViewModel(movieId: movieId)
        viewModel?.fetchMovieDetail()
        viewModel?.setUpDelegate(delegate: self)
    }
    
    //MARK: - Private Methods
    private func setupLottieView() {
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.addSubview(lottieAnimation)
        NSLayoutConstraint.activate([
            lottieAnimation.widthAnchor.constraint(equalToConstant: 75),
            lottieAnimation.heightAnchor.constraint(equalToConstant: 75),
            lottieAnimation.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            lottieAnimation.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor)
        ])
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()
    }
    
    private func stopLottieView() {
        lottieAnimation.stop()
        lottieAnimation.removeFromSuperview()
    }
}

// MARK: - PosterCollectionViewModelDelegate

extension PosterCollectionViewCell: PosterCollectionViewModelDelegate {
    func didFetchMovieDetailSuccess() {
        self.movieNameLabel.text = viewModel?.getMovieDetailName
        
        setupLottieView()
        guard let image = URL(string: Api.posterPath + (viewModel?.getMovieDetailPoster ?? "")) else { return }
        movieImageView.loadImageFromURL(image) { resulti in
            switch resulti {
            case .success(let image):
                self.stopLottieView()
                self.movieImageView.image = image
            case .failure(_):
                self.stopLottieView()
            }
        }
        
    }
}
