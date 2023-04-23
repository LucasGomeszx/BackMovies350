//
//  ActorCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    
    static let identifier: String = "ActorCollectionViewCell"
    
    var viewModel: ActorCollectionViewCellViewModel?
    
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
        guard let url = URL(string: Api.posterPath + (viewModel?.getActorProfilePath ?? "")) else {return}
        actorImage.loadImageFromURL(url)
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
