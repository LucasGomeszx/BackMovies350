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
    
    private var viewModel: StreamingCellViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func setupCell(provider: Flatrate) {
        viewModel = StreamingCellViewModel(provider: provider)
        guard let url = URL(string: Api.posterPath + (provider.logoPath ?? "")) else {return}
        logoImage.loadImageFromURL(url)
    }

}
