//
//  MapTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

enum MapStrings: String {
    case mapLabel = "Que tal um cineminha?"
}

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
        mapLabel.text = MapStrings.mapLabel.rawValue
        mapLabel.textColor = .white
    }

}
