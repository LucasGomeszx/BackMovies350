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
        viewModel.fetchPopularActor()
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
        actorCollectionView.register(EmptyActorCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyActorCollectionViewCell.identifier)
    }
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ActorSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.getActorCount == 0 {
            return 1
        }else {
            return viewModel.getActorCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.getActorCount == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyActorCollectionViewCell.identifier, for: indexPath) as? EmptyActorCollectionViewCell
            return cell ?? UICollectionViewCell()
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchActorCollectionViewCell.identifier, for: indexPath) as? SearchActorCollectionViewCell
            cell?.setupCell(actor: viewModel.getActorInfo(index: indexPath.row))
            if viewModel.getActorCount - 1 == indexPath.row {
                viewModel.getMoreActors()
            }
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.getActorCount == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else {
            return viewModel.getActorCellSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: ActorDetailViewController? = UIStoryboard(name: MovieDetailString.actorDetailView.rawValue, bundle: nil).instantiateViewController(identifier: MovieDetailString.actorDetailView.rawValue) { coder -> ActorDetailViewController? in
            return ActorDetailViewController(coder: coder, actorId: self.viewModel.getActorId(index: indexPath.row))
        }
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
    }
    
}

//MARK: - UISearchBarDelegate
extension ActorSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchActor(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: - ActorSearchViewModelProtocol
extension ActorSearchViewController: ActorSearchViewModelProtocol {
    func didFetchActorSuccess() {
        actorCollectionView.reloadData()
    }
}
