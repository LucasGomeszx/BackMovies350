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
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .black
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        actorImage.contentMode = .scaleAspectFill
        actorNameLabel.text = "Matthew McConaughey"
        actorNameLabel.textColor = .white
        personLabel.text = "Joseph Coop Cooper"
        personLabel.textColor = UIColor(named: "TextColor")
    }

}
