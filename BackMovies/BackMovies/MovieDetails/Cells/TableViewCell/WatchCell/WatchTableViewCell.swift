//
//  WatchTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/03/23.
//

import UIKit

protocol WatchCellStringsProtocol: AnyObject {
    func didFetchProviderFailure()
    func tappedYoutubeImage()
}

enum WatchCellStrings: String {
    case whereWatch = "Onde assistir ?"
    case movieVideos = "Que tal videos sobre o filme ?"
    case youtubeImage = "youtube"
}

class WatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collectionViewLabel: UILabel!
    @IBOutlet weak var watchCollectionView: UICollectionView!
    @IBOutlet weak var youtubeLabel: UILabel!
    @IBOutlet weak var youtubeImage: UIImageView!
    @IBOutlet weak var lineView: UIView!
    
    static let identifier: String = String(describing: WatchTableViewCell.self)
    private weak var delegate: WatchCellStringsProtocol?
    var viewModel: WatchCellViewModel = WatchCellViewModel()
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        configureCollection()
    }
    
    public func setUpCell(movieDetail: MovieDetailModel, delegate: WatchCellStringsProtocol) {
        self.delegate = delegate
        viewModel.setUpViewModel(movieDetail: movieDetail, delegate: self)
    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        collectionViewLabel.text = WatchCellStrings.whereWatch.rawValue
        collectionViewLabel.textColor = .white
        watchCollectionView.backgroundColor = .clear
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedYoutubeImage))
        youtubeLabel.text = WatchCellStrings.movieVideos.rawValue
        youtubeLabel.textColor = .white
        youtubeImage.image = UIImage(named: WatchCellStrings.youtubeImage.rawValue)
        youtubeImage.addGestureRecognizer(gesture)
        youtubeImage.isUserInteractionEnabled = true
        lineView.backgroundColor = .lineGray
    }
    
    private func configureCollection() {
        watchCollectionView.delegate = self
        watchCollectionView.dataSource = self
        if let layout = watchCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        watchCollectionView.register(StreamingCollectionViewCell.nib(), forCellWithReuseIdentifier: StreamingCollectionViewCell.identifier)
        watchCollectionView.register(EmptyCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
    }
    
    @objc func tappedYoutubeImage() {
        delegate?.tappedYoutubeImage()
    }

}

    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension WatchTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProviderCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.isEmpty {
        case true:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as? EmptyCollectionViewCell
            return cell ?? UICollectionViewCell()
        case false:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StreamingCollectionViewCell.identifier, for: indexPath) as? StreamingCollectionViewCell
            cell?.setupCell(provider: viewModel.getProvider(index: indexPath.row))
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.isEmpty {
        case true:
            return viewModel.getEmptyCellSize
        case false:
            return viewModel.getProviderCellSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
}

extension WatchTableViewCell: WatchCellViewModelProtocol {
    func didFetchProviderSuccess() {
        watchCollectionView.reloadData()
    }
    
    func didFetchProviderFailure() {
        delegate?.didFetchProviderFailure()
    }
    
}
