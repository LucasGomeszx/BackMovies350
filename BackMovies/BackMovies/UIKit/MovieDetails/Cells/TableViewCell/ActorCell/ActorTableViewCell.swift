//
//  ActorTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

protocol ActorTableViewCellDelegate: NSObject {
    func navActorDetail(actorId: Int)
    func didFetchActorError()
}

class ActorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    static let identifier: String = String(describing: ActorTableViewCell.self)
    
    private var viewModel: ActorCellViewModel = ActorCellViewModel()
    weak var delegate: ActorTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        configureCollection()
    }
    
    //MARK: - SetUps
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        actorLabel.text = "Elenco:"
        actorLabel.textColor = .white
        actorCollectionView.backgroundColor = .clear
    }
    
    private func configureCollection() {
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        if let layout = actorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        actorCollectionView.register(ActorCollectionViewCell.nib(), forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
    }
    
    public func setUpCell(movieDetail: MovieDetailModel) {
        viewModel.setUpViewModel(movieDetail: movieDetail)
    }
    
}

//MARK: - CollectionView Delegate, DataSource, FlowLayout

extension ActorTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getActorCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.identifier, for: indexPath) as? ActorCollectionViewCell
        cell?.setUpCell(actor: viewModel.getCast(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navActorDetail(actorId: viewModel.getCastId(index: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
