//
//  ActorTopTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

enum ActorTopStrings: String {
    case bioLabel = "Biografia:"
}

class ActorTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioContentLabel: UILabel!
    
    static let identifier: String = String(describing: ActorTopTableViewCell.self)
    
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
        actorImage.loadImageFromURL(url) { result in
            switch result {
            case .success(let image):
                self.actorImage.image = image
            case .failure(_):
                break
            }
        }
        actorNameLabel.text = viewModel?.getActorName
        bioContentLabel.text = viewModel?.getActorBio
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        actorImage.layer.cornerRadius = 15
        actorImage.clipsToBounds = true
        actorNameLabel.textAlignment = .center
        actorNameLabel.textColor = .white
        bioLabel.text = ActorTopStrings.bioLabel.rawValue
        bioLabel.textColor = .textColor
        bioContentLabel.font = UIFont.systemFont(ofSize: 14)
        bioContentLabel.textColor = .textColor
    }
    
}
