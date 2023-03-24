//
//  PosterTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/03/23.
//

import UIKit

class PosterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    static let identifier: String = "PosterTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configCollectionView()
    }
    
    //MARK: - SetUps
    
    private func configCollectionView() {
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        posterCollectionView.isScrollEnabled = false
        if let layout = posterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        posterCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
    
    private func configureView() {
        posterCollectionView.backgroundColor = .gray
        posterCollectionView.layer.cornerRadius = 15
        contentView.backgroundColor = .clear
    }

}

//MARK: - UICollectionView Delegate, DataSource
extension PosterTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
    }
    
}
