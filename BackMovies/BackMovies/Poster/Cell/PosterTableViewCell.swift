//
//  PosterTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/03/23.
//

import UIKit

class PosterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    static let identifier: String = "PosterTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
