//
//  StreamingCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

class StreamingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    static let identifier: String = "StreamingCollectionViewCell"
    var viewModel: StreamingCellViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setUpCell() {
        viewModel = StreamingCellViewModel()
    }

}
