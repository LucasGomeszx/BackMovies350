//
//  ActorTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit

protocol ActorTableViewCellDelegate: NSObject {
    func navActorDetail()
}

class ActorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    static let identifier: String = "ActorTableViewCell"
    
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
    
    public func setUpCell(id: Int) {
        viewModel.setUpViewModel(id: id)
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchActors()
    }
    
}

//MARK: - CollectionView Delegate, DataSource, FlowLayout

extension ActorTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getActorCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.identifier, for: indexPath) as? ActorCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navActorDetail()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}

extension ActorTableViewCell : ActorCellViewModelDelegate {
    func didFetchMovies() {
        actorCollectionView.reloadData()
        print("SEM ERRO")
    }
    
    func didFailToFetchMovies(with error: String) {
        print(error)
    }
    
}
