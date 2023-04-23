//
//  MapTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mapLabel: UILabel!
    
    static let identifier: String = String(describing: MapTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        mapLabel.text = "Que tal um cineminha ?"
        mapLabel.textColor = .white
    }

}
