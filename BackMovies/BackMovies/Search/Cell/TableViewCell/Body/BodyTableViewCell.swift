//
//  BodyTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

protocol BodyTableViewCellDelegate: NSObject {
    func navSearchSelected()
}

class BodyTableViewCell: UITableViewCell {

    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    static let identifier: String = "BodyTableViewCell"
    
    weak var delegate: BodyTableViewCellDelegate?
    
    var nome: [String] = []
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    public func setUpCell(nome: [String]) {
        self.nome = nome
    }

    private func setupCollectionView() {
        searchCollectionView.backgroundColor = .clear
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.isScrollEnabled = false
        if let layout = searchCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        searchCollectionView.register(BodyCollectionViewCell.nib(), forCellWithReuseIdentifier: BodyCollectionViewCell.identifier)
    }
    
}

//MARK: - UICollectionView Delegate, DataSource

extension BodyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BodyCollectionViewCell.identifier, for: indexPath) as? BodyCollectionViewCell
        cell?.setUpCell(nome: nome[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navSearchSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
    }
    
}
