//
//  HeadTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

protocol HeadTableViewCellDelegate: NSObject {
    func navMovieButton()
    func navActorButton()
}

enum HeadStrings: String {
    case movieButton = "Filmes"
    case actorButton = "Ator"
    case genderLabel = "Gênero"
}

class HeadTableViewCell: UITableViewCell {
    

    @IBOutlet weak var movieButton: UILabel!
    @IBOutlet weak var actorButton: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    static let identifier: String = String(describing: HeadTableViewCell.self)
    
    weak var delegate: HeadTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        movieButton.backgroundColor = .black
        movieButton.textColor = .white
        movieButton.clipsToBounds = true
        movieButton.layer.cornerRadius = 15
        movieButton.text = HeadStrings.movieButton.rawValue
        let movieGesture = UITapGestureRecognizer(target: self, action: #selector(tappedMovieButton))
        movieButton.addGestureRecognizer(movieGesture)
        movieButton.isUserInteractionEnabled = true
        actorButton.backgroundColor = .black
        actorButton.textColor = .white
        actorButton.clipsToBounds = true
        actorButton.layer.cornerRadius = 15
        actorButton.text = HeadStrings.actorButton.rawValue
        let actorGesture = UITapGestureRecognizer(target: self, action: #selector(tappedActorButton))
        actorButton.addGestureRecognizer(actorGesture)
        actorButton.isUserInteractionEnabled = true
        genderLabel.textColor = .white
        genderLabel.text = HeadStrings.genderLabel.rawValue
    }
    
    @objc func tappedMovieButton(_ sender: Any) {
        delegate?.navMovieButton()
    }
    
    @objc func tappedActorButton(_ sender: Any) {
        delegate?.navActorButton()
    }
    
}
