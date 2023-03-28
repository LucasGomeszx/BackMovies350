//
//  MovieTopTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

class MovieTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRateLebel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    static let identifier: String = "MovieTopTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
        posterImageView.image = UIImage(named: "inter")
        movieNameLabel.text = "Interestelar"
        movieNameLabel.textColor = .white
        starImageView.image = UIImage(systemName: "star")
        starImageView.tintColor = .white
        movieRateLebel.text = "9/10"
        movieRateLebel.textColor = .white
        heartImageView.image = UIImage(systemName: "heart")
        heartImageView.tintColor = .white
    }
    
}
