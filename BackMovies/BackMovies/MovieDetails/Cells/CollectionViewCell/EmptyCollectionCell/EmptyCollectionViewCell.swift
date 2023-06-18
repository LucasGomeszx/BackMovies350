//
//  EmptyCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 18/06/23.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    static let identifier: String = String(describing: EmptyCollectionViewCell.self)
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        emptyLabel.textColor = .textColor
        emptyLabel.text = "Indisponivel"
    }

}
