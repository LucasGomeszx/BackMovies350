//
//  ActorTopTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

class ActorTopTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioContentLabel: UILabel!
    
    static let identifier: String = "ActorTopTableViewCell"
    
    private var viewModel: ActorTopCellViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public func setUpCell(actor: ActorModel) {
        viewModel = ActorTopCellViewModel(actorDetail: actor)
        guard let url = URL(string: Api.posterPath + (viewModel?.getAtorImage ?? "")) else {return}
        actorImage.loadImageFromURL(url)
        actorNameLabel.text = viewModel?.getActorName
        bioContentLabel.text = viewModel?.getActorBio
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        actorImage.layer.cornerRadius = 15
        actorImage.clipsToBounds = true
        actorNameLabel.textAlignment = .center
        actorNameLabel.textColor = .white
        bioLabel.text = "Biografia: "
        bioLabel.textColor = UIColor(named: "TextColor")
        bioContentLabel.textColor = UIColor(named: "TextColor")
    }

}
