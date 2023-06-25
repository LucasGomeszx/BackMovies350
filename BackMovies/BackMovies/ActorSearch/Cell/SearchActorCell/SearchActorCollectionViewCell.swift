//
//  SearchActorCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/23.
//

import UIKit

class SearchActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    static let identifier: String = String(describing: SearchActorCollectionViewCell.self)
    
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
        guard let url = URL(string: Api.posterPath + (actor.profilePath ?? "")) else {return}
        self.actorImage.loadImageFromURL(url)
    }

}
