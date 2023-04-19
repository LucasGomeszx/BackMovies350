//
//  PosterCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/03/23.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    static let identifier: String = "PosterCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    //MARK: - SetUps
    
    private func setUpView() {
        mainView.backgroundColor = .black
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        movieNameLabel.textColor = .white
    }
    
    public func setUpCell(movies: Poster) {
        self.movieNameLabel.text = movies.title
        guard let image = URL(string: Api.posterPath + "\(movies.posterPath ?? "")") else {return}
        movieImageView.loadImageFromURL(image, placeholder: nil, errorImage: UIImage(systemName: "eraser.fill"))
    }
    
}
