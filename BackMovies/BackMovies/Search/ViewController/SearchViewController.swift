//
//  SearchViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit
import Lottie

enum SearchTableViewSection: Int {
    case head
    case body
}

enum SearchStrings: String {
    case titleLabel = "Busca"
    case searchSelected = "SearchSelectedView"
    case alertError = "Error"
    case genresError = "Nao foi possivel carregar os Gêneros"
    case actorSearchView  = "ActorSearchView"
    case actorSearchViewController = "ActorSearchViewController"
}

class SearchViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lottieLoadView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    
    var viewModel: SearchViewModel = SearchViewModel()
    let lottieAnimation = LottieAnimationView(name: ProfileStrings.lottieAnimationName.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        startLottieAnimation()
        configureNavigation()
        configureTableView()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchGenres()
    }
    
    private func setUpView() {
        lottieLoadView.backgroundColor = .lottieBack
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
        titleLabel.text = SearchStrings.titleLabel.rawValue
        searchTableView.backgroundColor = .backGray
        searchTableView.layer.cornerRadius = 15
    }
    
    private func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.allowsSelection = false
        searchTableView.separatorStyle = .none
        searchTableView.register(HeadTableViewCell.nib(), forCellReuseIdentifier: HeadTableViewCell.identifier)
        searchTableView.register(BodyTableViewCell.nib(), forCellReuseIdentifier: BodyTableViewCell.identifier)
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
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

//MARK: - UITableViewDelegate,UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableViewCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SearchTableViewSection(rawValue: indexPath.row){
        case .head:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadTableViewCell.identifier, for: indexPath) as? HeadTableViewCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        case .body:
            let cell = tableView.dequeueReusableCell(withIdentifier: BodyTableViewCell.identifier, for: indexPath) as? BodyTableViewCell
            cell?.delegate = self
            cell?.setUpCell(genresList: viewModel.getGenresList)
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SearchTableViewSection(rawValue: indexPath.row){
        case .head:
            return viewModel.getHeadCellSize
        default:
            return viewModel.getBodyCellSize
        }
    }
}

//MARK: - SearchViewModelDelegate

extension SearchViewController: SearchViewModelDelegate {
    func didFetchGenresSucess() {
        stopLottieAnimation()
        searchTableView.reloadData()
    }
    
    func didFetchGenresFailure() {
        Alert.showAlert(on: self, withTitle: SearchStrings.alertError.rawValue, message: SearchStrings.genresError.rawValue, actions: nil)
    }
}

//MARK: - BodyTableViewCellDelegate

extension SearchViewController: BodyTableViewCellDelegate {
    func navSearchSelected(genres: Genre) {
        let vc: SearchSelectedViewController? = UIStoryboard(name: SearchStrings.searchSelected.rawValue, bundle: nil).instantiateViewController(identifier: SearchStrings.searchSelected.rawValue) { coder -> SearchSelectedViewController? in
            return SearchSelectedViewController(coder: coder, type: .genres, genres: genres)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

//MARK: - HeadTableViewCellDelegate

extension SearchViewController: HeadTableViewCellDelegate {
    func navMovieButton() {
        let vc: SearchSelectedViewController? = UIStoryboard(name: SearchStrings.searchSelected.rawValue, bundle: nil).instantiateViewController(identifier: SearchStrings.searchSelected.rawValue) { coder -> SearchSelectedViewController? in
            return SearchSelectedViewController(coder: coder, type: .movies, genres: nil)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func navActorButton() {
        let vc: ActorSearchViewController? = UIStoryboard(name: SearchStrings.actorSearchView.rawValue, bundle: nil).instantiateViewController(withIdentifier: SearchStrings.actorSearchViewController.rawValue) as? ActorSearchViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}
