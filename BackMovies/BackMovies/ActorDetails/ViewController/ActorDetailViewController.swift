//
//  ActorDetailViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit
import Lottie

enum ActorDetailSection: Int {
    case ActorTopCell
    case ActorInfoCell
    case ActorMoviesCell
}

enum ActorDetailStrings: String {
    case actorLabel = "Detalhes"
    case movieDetail = "MoviesDetailsView"
    case alertError = "Error"
    case alertActorError = "Nao foi possivel carregar detalhes do ator."
    case actorMovieError = "Nao foi possivel carregar filmes do ator."
}

class ActorDetailViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lottieLoadView: UIView!
    @IBOutlet weak var actorTitleLabel: UILabel!
    @IBOutlet weak var actorTableView: UITableView!
    @IBOutlet weak var backButton: UIImageView!
    
    var viewModel: ActorDetailsViewModel
    let lottieAnimation = LottieAnimationView(name: ProfileStrings.lottieAnimationName.rawValue)
    
    init?(coder: NSCoder, actorId: Int) {
        viewModel = ActorDetailsViewModel(actorId: actorId)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        startLottieAnimation()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchActor()
    }
    
    private func setUpView() {
        lottieLoadView.backgroundColor = .lottieBack
        mainView.backgroundColor = .black
        actorTitleLabel.text = ActorDetailStrings.actorLabel.rawValue
        actorTitleLabel.textColor = .white
        actorTableView.backgroundColor = .backGray
        actorTableView.layer.cornerRadius = 15
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackButton))
        backButton.tintColor = .white
        backButton.addGestureRecognizer(gesture)
        backButton.isUserInteractionEnabled = true
    }
    
    private func configureTableView() {
        actorTableView.delegate = self
        actorTableView.dataSource = self
        actorTableView.separatorStyle = .none
        actorTableView.allowsSelection = false
        actorTableView.register(ActorTopTableViewCell.nib(), forCellReuseIdentifier: ActorTopTableViewCell.identifier)
        actorTableView.register(ActorInfoTableViewCell.nib(), forCellReuseIdentifier: ActorInfoTableViewCell.identifier)
        actorTableView.register(ActorMoviesTableViewCell.nib(), forCellReuseIdentifier: ActorMoviesTableViewCell.identifier)
    }
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func startLottieAnimation() {
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        lottieLoadView.addSubview(lottieAnimation)
        NSLayoutConstraint.activate([
            lottieAnimation.widthAnchor.constraint(equalToConstant: 65),
            lottieAnimation.heightAnchor.constraint(equalToConstant: 65),
            lottieAnimation.centerXAnchor.constraint(equalTo: lottieLoadView.centerXAnchor),
            lottieAnimation.centerYAnchor.constraint(equalTo: lottieLoadView.centerYAnchor)
        ])
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()
        lottieLoadView.isHidden = false
    }
    
    private func stopLottieAnimation() {
        lottieAnimation.stop()
        lottieLoadView.isHidden = true
    }
    
}

//MARK: - TableViewDelegate, TableViewDataSource

extension ActorDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTableViewCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ActorDetailSection(rawValue: indexPath.row){
        case .ActorTopCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorTopTableViewCell.identifier, for: indexPath) as? ActorTopTableViewCell
            cell?.setUpCell(actor: viewModel.getActorDetail)
            return cell ?? UITableViewCell()
        case .ActorInfoCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorInfoTableViewCell.identifier, for: indexPath) as? ActorInfoTableViewCell
            cell?.setUpCell(actor: viewModel.getActorDetail)
            return cell ?? UITableViewCell()
        case .ActorMoviesCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorMoviesTableViewCell.identifier, for: indexPath) as? ActorMoviesTableViewCell
            cell?.setUpCell(actorModel: viewModel.getActorDetail)
            cell?.delegate = self
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ActorDetailSection(rawValue: indexPath.row) {
        case .ActorTopCell:
            return viewModel.getActorTopCell(width: tableView.frame.size.width - 32)
        case .ActorInfoCell:
            return viewModel.getActorInfoCell
        case .ActorMoviesCell:
            return viewModel.getActorMoviesCell
        default:
            return 0
        }
    }
    
}

//MARK: - ActorMoviesTableViewCellDelegate

extension ActorDetailViewController: ActorMoviesTableViewCellDelegate {
    func navActorMovies(movieId: MovieCellModel) {
        let vc: MovieDetailsViewController? = UIStoryboard(name: ActorDetailStrings.movieDetail.rawValue, bundle: nil).instantiateViewController(identifier: ActorDetailStrings.movieDetail.rawValue) { coder -> MovieDetailsViewController? in
            return MovieDetailsViewController(coder: coder, movieCellModel: movieId)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func didFetchActorMoviesFailure() {
        Alert.showAlert(on: self, withTitle: ActorDetailStrings.alertError.rawValue, message: ActorDetailStrings.actorMovieError.rawValue, actions: nil)
    }
}

//MARK: - ActorDetailsViewModelDelegate

extension ActorDetailViewController: ActorDetailsViewModelDelegate {
    func didFetchActor() {
        configureTableView()
        stopLottieAnimation()
    }
    
    func didFailToFetchActor() {
        Alert.showAlert(on: self, withTitle: ActorDetailStrings.alertError.rawValue, message: ActorDetailStrings.alertActorError.rawValue, actions: nil)
    }
}
