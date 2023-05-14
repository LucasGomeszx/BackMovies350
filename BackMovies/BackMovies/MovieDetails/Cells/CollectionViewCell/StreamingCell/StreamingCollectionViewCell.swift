//
//  StreamingCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

class StreamingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    static let identifier: String = String(describing: StreamingCollectionViewCell.self)
    
    var viewModel: StreamingCellViewModel = StreamingCellViewModel()
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
