//
//  BodyCollectionViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

class BodyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier: String = "BodyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    private func setUpCell() {
        mainView.backgroundColor = .black
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        nameLabel.textColor = .white
    }
    
    public func setUpCell(nome: String) {
        nameLabel.text = nome
    }

}
