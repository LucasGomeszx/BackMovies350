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

class HeadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieButton: UIButton!
    @IBOutlet weak var actorMovie: UIButton!
    @IBOutlet weak var genderLabel: UILabel!
    
    static let identifier: String = "HeadTableViewCell"
    
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
        movieButton.tintColor = .white
        movieButton.layer.cornerRadius = 15
        movieButton.setTitle("Filmes", for: .normal)
        actorMovie.backgroundColor = .black
        actorMovie.tintColor = .white
        actorMovie.layer.cornerRadius = 15
        actorMovie.setTitle("Ator", for: .normal)
        genderLabel.textColor = .white
        genderLabel.text = "Gênero"
    }
    
    @IBAction func tappedMovieButton(_ sender: Any) {
        delegate?.navMovieButton()
    }
    
    @IBAction func tappedActorButton(_ sender: Any) {
        delegate?.navActorButton()
    }
    
}
