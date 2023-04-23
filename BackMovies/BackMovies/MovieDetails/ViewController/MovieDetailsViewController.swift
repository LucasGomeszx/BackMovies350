//
//  MovieDetailsViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: MovieDetailViewModel
    
    init?(coder: NSCoder, poster: Poster) {
        self.viewModel = MovieDetailViewModel(poster: poster)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
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
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTopTableViewCell.identifier, for: indexPath) as? MovieTopTableViewCell
            cell?.setUpCell(poster: viewModel.getMovie)
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrailerTableViewCell.identifier, for: indexPath) as? TrailerTableViewCell
            cell?.setUpCell(movie: viewModel.getMovie)
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WatchTableViewCell.identifier, for: indexPath) as? WatchTableViewCell
            cell?.setUpCell(movie: viewModel.getMovie)
            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorTableViewCell.identifier, for: indexPath) as? ActorTableViewCell
            cell?.delegate = self
            cell?.setUpCell(id: viewModel.getMovieId)
            return cell ?? UITableViewCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: RetatedTableViewCell.identifier, for: indexPath) as? RetatedTableViewCell
            cell?.delegate = self
            cell?.setUpCell(id: viewModel.getMovieId)
            return cell ?? UITableViewCell()
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return viewModel.getMovieTopCellSize
        case 1:
            return viewModel.getTrailerCellSize
        case 2:
            return viewModel.getWatchCellSize
        case 3:
            return viewModel.getActorCellSize
        case 4:
            return viewModel.getRelatedCell
        case 5:
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
    func navRelatedMovies(movie: Poster) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: "MoviesDetailsView", bundle: nil).instantiateViewController(identifier: "MoviesDetailsView") { coder -> MovieDetailsViewController? in
            return MovieDetailsViewController(coder: coder, poster: movie)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}
