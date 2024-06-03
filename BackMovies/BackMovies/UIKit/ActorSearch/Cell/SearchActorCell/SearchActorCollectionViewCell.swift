//
//  SearchActorCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/23.
//

import UIKit
import Lottie

class SearchActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    static let identifier: String = String(describing: SearchActorCollectionViewCell.self)
    private let lottieAnimation: LottieAnimationView = LottieAnimationView(name: "imageLoad")
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        actorName.textColor = .white
        mainView.backgroundColor = .black
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
    }
    
    func setupCell(actor: ActorInfo) {
        self.actorName.text = actor.name ?? ""
        setupLottieView()
        guard let url = URL(string: Api.posterPath + (actor.profilePath ?? "")) else {return}
        self.actorImage.loadImageFromURL(url) { resulti in
            switch resulti {
            case .success(let image):
                self.stopLottieView()
                self.actorImage.image = image
            case .failure(_):
                self.stopLottieView()
            }
        }
    }
    
    private func setupLottieView() {
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        actorImage.addSubview(lottieAnimation)
        NSLayoutConstraint.activate([
            lottieAnimation.widthAnchor.constraint(equalToConstant: 75),
            lottieAnimation.heightAnchor.constraint(equalToConstant: 75),
            lottieAnimation.centerXAnchor.constraint(equalTo: actorImage.centerXAnchor),
            lottieAnimation.centerYAnchor.constraint(equalTo: actorImage.centerYAnchor)
        ])
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()
    }
    
    private func stopLottieView() {
        lottieAnimation.stop()
        lottieAnimation.removeFromSuperview()
    }

}
