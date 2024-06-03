//
//  EmptyActorCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 25/06/23.
//

import UIKit

class EmptyActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    static let identifier: String = String(describing: EmptyActorCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        emptyLabel.text = "Nenhum ator encontrado."
        emptyLabel.textColor = .textColor
    }
    
}
