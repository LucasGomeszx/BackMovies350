//
//  MovieDetailsViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

enum TableViewSection: Int {
    case movieTopCell
    case trailerCell
    case watchCell
    case actorsCell
    case relatedCell
    case mapCell
}

enum MovieDetailString: String {
    case titleLabel = "Detalhes"
    case actorDetailView = "ActorDetailView"
    case movieDatailView = "MoviesDetailsView"
    case alertError = "Error"
    case actorError = "Nao foi possivel carregar o elenco."
    case providerError = "Não foi possível carregar provedores."
    case similarMoviesError = "Nao foi possível carregar filmes similares."
}

class MovieDetailsViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: MovieDetailViewModel
    
    init?(coder: NSCoder, movieId: MovieCellModel) {
        self.viewModel = MovieDetailViewModel(movieId: movieId)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchMovieDetail()
    }
    
    private func setUpView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackButton))
        backImageView.addGestureRecognizer(gesture)
        backImageView.isUserInteractionEnabled = true
        backImageView.tintColor = .white
        mainView.backgroundColor = .black
        titleLabel.text = MovieDetailString.titleLabel.rawValue
        titleLabel.textColor = .white
        detailTableView.layer.cornerRadius = 15
        detailTableView.backgroundColor = .backGray
    }
    
    private func setUpTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.allowsSelection = false
        detailTableView.separatorStyle = .none
        detailTableView.register(MovieTopTableViewCell.nib(), forCellReuseIdentifier: MovieTopTableViewCell.identifier)
        detailTableView.register(TrailerTableViewCell.nib(), forCellReuseIdentifier: TrailerTableViewCell.identifier)
        detailTableView.register(WatchTableViewCell.nib(), forCellReuseIdentifier: WatchTableViewCell.identifier)
        detailTableView.register(ActorTableViewCell.nib(), forCellReuseIdentifier: ActorTableViewCell.identifier)
        detailTableView.register(RelatedTableViewCell.nib(), forCellReuseIdentifier: RelatedTableViewCell.identifier)
        detailTableView.register(MapTableViewCell.nib(), forCellReuseIdentifier: MapTableViewCell.identifier)
    }
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTableViewCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableViewSection(rawValue: indexPath.row){
        case .movieTopCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTopTableViewCell.identifier, for: indexPath) as? MovieTopTableViewCell
            cell?.setUpCell(movieDetail: viewModel.getMovieDetail)
            return cell ?? UITableViewCell()
        case .trailerCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrailerTableViewCell.identifier, for: indexPath) as? TrailerTableViewCell
            cell?.setUpCell(movieDetail: viewModel.getMovieDetail)
            return cell ?? UITableViewCell()
        case .watchCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: WatchTableViewCell.identifier, for: indexPath) as? WatchTableViewCell
            cell?.setUpCell(movieDetail: viewModel.getMovieDetail, delegate: self)
            return cell ?? UITableViewCell()
        case .actorsCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorTableViewCell.identifier, for: indexPath) as? ActorTableViewCell
            cell?.delegate = self
            cell?.setUpCell(id: viewModel.getMovieId)
            return cell ?? UITableViewCell()
        case .relatedCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: RelatedTableViewCell.identifier, for: indexPath) as? RelatedTableViewCell
            cell?.delegate = self
            cell?.setUpCell(id: viewModel.getMovieId)
            return cell ?? UITableViewCell()
        case .mapCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch TableViewSection(rawValue: indexPath.row) {
        case .movieTopCell:
            return viewModel.getMovieTopCellSize
        case .trailerCell:
            return viewModel.getTrailerCellSize(width: tableView.frame.size.width - 32)
        case .watchCell:
            return viewModel.getWatchCellSize
        case .actorsCell:
            return viewModel.getActorCellSize
        case .relatedCell:
            return viewModel.getRelatedCell
        case .mapCell:
            return viewModel.getMapCellSize
        default:
            return 0
        }
    }
    
}

//MARK: - ActorTableViewCellDelegate

extension MovieDetailsViewController: ActorTableViewCellDelegate {
    func navActorDetail(actorId: Int) {
        let vc: ActorDetailViewController? = UIStoryboard(name: MovieDetailString.actorDetailView.rawValue, bundle: nil).instantiateViewController(identifier: MovieDetailString.actorDetailView.rawValue) { coder -> ActorDetailViewController? in
            return ActorDetailViewController(coder: coder, actorId: actorId)
        }
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
    
    func didFetchActorError() {
        Alert.showAlert(on: self, withTitle: MovieDetailString.alertError.rawValue, message: MovieDetailString.actorError.rawValue, actions: nil)
    }
}

//MARK: - RelatedTableViewCellDelegate

extension MovieDetailsViewController: RelatedTableViewCellDelegate {
    func navRelatedMovies(movieId: MovieCellModel) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: MovieDetailString.movieDatailView.rawValue, bundle: nil).instantiateViewController(identifier: MovieDetailString.movieDatailView.rawValue) { coder -> MovieDetailsViewController? in
            return MovieDetailsViewController(coder: coder, movieId: movieId)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func didFailToFetchSimilarMovies() {
        Alert.showAlert(on: self, withTitle: MovieDetailString.alertError.rawValue, message: MovieDetailString.similarMoviesError.rawValue, actions: nil)
    }
    
}

//MARK: - MovieDetailViewModelDelegate

extension MovieDetailsViewController: MovieDetailViewModelDelegate {
    func fetchMovieDetailSuccess() {
        setUpTableView()
    }
    
    func fetchMovieDetailFailure(error: String) {
        Alert.showAlert(on: self, withTitle: MovieDetailString.alertError.rawValue, message: error, actions: nil)
    }
    
}

extension MovieDetailsViewController: WatchCellStringsProtocol {
    func didFetchProviderFailure() {
        Alert.showAlert(on: self, withTitle: MovieDetailString.alertError.rawValue, message: MovieDetailString.providerError.rawValue, actions: nil)
    }
    
    func tappedYoutubeImage() {
        viewModel.searchMovieOnYouTube()
    }
    
}
