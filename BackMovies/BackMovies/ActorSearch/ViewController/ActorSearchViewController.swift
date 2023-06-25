//
//  ActorSearchViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/23.
//

import UIKit

class ActorSearchViewController: UIViewController {

    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actorSearchBar: UISearchBar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    let viewModel: ActorSearchViewModel = ActorSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.setupDelegate(delegate: self)
        viewModel.fetchActor()
        configCollectionView()
    }
    
    func setupView() {
        self.view.backgroundColor = .black
        titleLabel.text = "Atores"
        titleLabel.textColor = .white
        contentView.backgroundColor = .backGray
        contentView.layer.cornerRadius = 15
        actorSearchBar.barTintColor = .backGray
        actorSearchBar.delegate = self
        actorCollectionView.backgroundColor = .clear
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackButton))
        backButton.addGestureRecognizer(gesture)
        backButton.isUserInteractionEnabled = true
        backButton.tintColor = .white
    }
    
    private func configCollectionView() {
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        if let layout = actorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        actorCollectionView.register(SearchActorCollectionViewCell.nib(), forCellWithReuseIdentifier: SearchActorCollectionViewCell.identifier)
    }
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ActorSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getActorCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchActorCollectionViewCell.identifier, for: indexPath) as? SearchActorCollectionViewCell
        cell?.setupCell(actor: viewModel.getActorInfo(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getActorCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
    }
    
}

extension ActorSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchActor(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ActorSearchViewController: ActorSearchViewModelProtocol {
    func didFetchActorSuccess() {
        actorCollectionView.reloadData()
    }
}
