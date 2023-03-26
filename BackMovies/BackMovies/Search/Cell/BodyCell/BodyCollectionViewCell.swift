//
//  BodyCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

class BodyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var searchButton: UIButton!
    
    static let identifier: String = "BodyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 15
    }

}
