//
//  TrailerTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

//enum TrailerCellString: String {
//    case 
//}

class TrailerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var trailerImageView: UIImageView!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var sinopseContencLabel: UILabel!
    
    static let identifier: String = String(describing: TrailerTableViewCell.self)
    
    var viewModel: TrailerCellViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public func setUpCell(movieDetail: MovieDetail) {
        viewModel = TrailerCellViewModel(movieDetail: movieDetail)
        sinopseContencLabel.text = viewModel?.getOverview
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        lineView.backgroundColor = .lineGray
        trailerLabel.text = "Treiler:"
        trailerLabel.textColor = .textColor
        sinopseLabel.text = "Sinopse"
        sinopseLabel.textColor = .textColor
        sinopseContencLabel.textColor = .textColor
    }

}
