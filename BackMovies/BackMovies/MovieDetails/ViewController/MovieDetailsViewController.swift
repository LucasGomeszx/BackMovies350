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

class MovieDetailsViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: MovieDetailViewModel
    
    init?(coder: NSCoder, movieId: Int) {
        self.viewModel = MovieDetailViewModel(movieId: movieId)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchMovieDetail()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .black
        titleLabel.text = "Detalhes"
        titleLabel.textColor = .white
        detailTableView.layer.cornerRadius = 15
        detailTableView.backgroundColor = UIColor(named: "BackGray")
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
        detailTableView.register(RetatedTableViewCell.nib(), forCellReuseIdentifier: RetatedTableViewCell.identifier)
        detailTableView.register(MapTableViewCell.nib(), forCellReuseIdentifier: MapTableViewCell.identifier)
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
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
            cell?.setUpCell(movieDetail: viewModel.getMovieDetail)
            return cell ?? UITableViewCell()
        case .actorsCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorTableViewCell.identifier, for: indexPath) as? ActorTableViewCell
            cell?.delegate = self
            cell?.setUpCell(id: viewModel.getMovieId)
            return cell ?? UITableViewCell()
        case .relatedCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: RetatedTableViewCell.identifier, for: indexPath) as? RetatedTableViewCell
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
            return viewModel.getTrailerCellSize
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
        let vc: ActorDetailViewController? = UIStoryboard(name: "ActorDetailView", bundle: nil).instantiateViewController(identifier: "ActorDetailView") { coder -> ActorDetailViewController? in
            return ActorDetailViewController(coder: coder, actorId: actorId)
        }
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
}

//MARK: - ActorTableViewCellDelegate

extension MovieDetailsViewController: RetatedTableViewCellDelegate {
    func navRelatedMovies(movieId: Int) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: "MoviesDetailsView", bundle: nil).instantiateViewController(identifier: "MoviesDetailsView") { coder -> MovieDetailsViewController? in
            return MovieDetailsViewController(coder: coder, movieId: movieId)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

//MARK - ViewModelDelegate

extension MovieDetailsViewController: MovieDetailViewModelDelegate {
    func suss() {
        detailTableView.reloadData()
    }
}
