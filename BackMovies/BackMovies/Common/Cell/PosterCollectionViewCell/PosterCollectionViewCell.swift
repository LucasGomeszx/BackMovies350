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
    
    public func setUpCell(data: MovieCellModel) {
        movieNameLabel.text = data.title
        startLottieAnimation()
        guard let url = URL(string: Api.posterPath + (data.posterPath ?? ""))else {return}
        movieImageView.loadImageFromURL(url) { result in
            switch result {
            case .success(let image):
                self.movieImageView.image = image
                self.stopLottieAnimation()
            case .failure(_):
                self.stopLottieAnimation()
            }
        }
    }
    
    //MARK: - Private Methods
    private func startLottieAnimation() {
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
    
    private func stopLottieAnimation() {
        lottieAnimation.stop()
        lottieAnimation.removeFromSuperview()
    }
}
