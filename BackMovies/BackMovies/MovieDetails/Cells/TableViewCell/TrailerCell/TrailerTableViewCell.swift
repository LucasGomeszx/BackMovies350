//
//  TrailerTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit
import youtube_ios_player_helper

enum TrailerCellStrings: String {
    case treiler = "Treiler"
    case overview = "Sinopse"
}

class TrailerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var videoView: YTPlayerView!
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
        viewModel?.setupDelegate(delegate: self)
        viewModel?.fetchMovieVideo()
        sinopseContencLabel.text = viewModel?.getOverview
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        lineView.backgroundColor = .lineGray
        trailerLabel.text = TrailerCellStrings.treiler.rawValue
        trailerLabel.textColor = .textColor
        sinopseLabel.text = TrailerCellStrings.overview.rawValue
        sinopseLabel.textColor = .textColor
        sinopseContencLabel.textColor = .textColor
    }

}

extension TrailerTableViewCell: TrailerCellViewModelProtocol {
    func didFetchMovieVideoSucess() {
        videoView.load(withVideoId: viewModel?.getMovieVideoKey ?? "")
    }
}
