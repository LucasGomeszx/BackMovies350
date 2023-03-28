//
//  SearchSelectedViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

protocol SearchSelectedViewControllerDelegate: NSObject {
    func navMovieDetail()
}

class SearchSelectedViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backTappedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var movieSearch: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    weak var delegate: SearchSelectedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configCollectionView()
        configureView()
    }
    
    private func configCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        if let layout = moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        moviesCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }

    private func configureView() {
        mainView.backgroundColor = .black
        contentView.backgroundColor = UIColor(named: "BackGray")
        contentView.layer.cornerRadius = 15
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        movieSearch.barTintColor = UIColor(named: "BackGray")
        moviesCollectionView.backgroundColor = .clear
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backTappedButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UICollectionView Delegate, DataSource
extension SearchSelectedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: "MoviesDetailsView", bundle: nil).instantiateViewController(withIdentifier: "MoviesDetailsView") as? MovieDetailsViewController
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
    }
    
}
