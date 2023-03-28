//
//  FavoriteViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
        configCollectionView()
    }
    
    private func configCollectionView() {
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        if let layout = favoriteCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        favoriteCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }

    private func configureView() {
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
        favoriteCollectionView.backgroundColor = UIColor(named: "BackGray")
        favoriteCollectionView.layer.cornerRadius = 15
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }

}

//MARK: - UICollectionView Delegate, DataSource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
