//
//  ActorCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit
import Lottie

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    
    static let identifier: String = "ActorCollectionViewCell"
    var viewModel: ActorCollectionViewCellViewModel?
    var lottieAnimation: LottieAnimationView = LottieAnimationView(name: "imageLoad")
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public func setUpCell(actor: Cast) {
        viewModel = ActorCollectionViewCellViewModel(actor: actor)
        actorNameLabel.text = viewModel?.getActorName
        personLabel.text = viewModel?.getActorCharacter
        setLottieView()
        guard let url = URL(string: Api.posterPath + (viewModel?.getActorProfilePath ?? "")) else {return}
        actorImage.loadImageFromURL(url) { result in
            switch result {
            case .success(let image):
                self.removeLottieView()
                self.actorImage.image = image
            case .failure(_):
                self.removeLottieView()
            }
        }
    }
    
    //MARK: - Private Methods
    private func setLottieView() {
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
    
    private func removeLottieView() {
        lottieAnimation.stop()
        lottieAnimation.removeFromSuperview()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .black
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        actorImage.contentMode = .scaleAspectFill
        actorNameLabel.textColor = .white
        personLabel.textColor = UIColor(named: "TextColor")
    }

}
