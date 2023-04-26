//
//  SocialMediaCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

class SocialMediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var socialMediaImageView: UIImageView!
    
    static let identifier: String = "SocialMediaCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var viewModel: SocialMediaViewModel = SocialMediaViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        socialMediaImageView.image = UIImage(named: viewModel.getSocialMediaImage)
    }

}
