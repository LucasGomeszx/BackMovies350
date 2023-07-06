//
//  MovieEmptyCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/23.
//

import UIKit

class MovieEmptyCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: MovieEmptyCollectionViewCell.self)
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var emptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        emptyLabel.textColor = .textColor
        emptyLabel.text = "Nenhum filme encontrado."
    }

}
