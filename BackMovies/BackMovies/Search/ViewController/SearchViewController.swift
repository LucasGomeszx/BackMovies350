//
//  SearchViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

enum SearchTableViewSection: Int {
    case head
    case body
}

class SearchViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    
    var viewModel: SearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureNavigation()
        configureTableView()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchGenres()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
        titleLabel.text = "Busca"
        searchTableView.backgroundColor = UIColor(named: "BackGray")
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
    
}

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
    func suss() {
        searchTableView.reloadData()
    }
}

//MARK: - BodyTableViewCellDelegate

extension SearchViewController: BodyTableViewCellDelegate {
    func navSearchSelected(genres: Genre) {
        let vc: SearchSelectedViewController? = UIStoryboard(name: "SearchSelectedView", bundle: nil).instantiateViewController(identifier: "SearchSelectedView") { coder -> SearchSelectedViewController? in
            return SearchSelectedViewController(coder: coder, code: 1, genres: genres)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

//MARK: - HeadTableViewCellDelegate

extension SearchViewController: HeadTableViewCellDelegate {
    func navMovieButton() {
        let vc: SearchSelectedViewController? = UIStoryboard(name: "SearchSelectedView", bundle: nil).instantiateViewController(identifier: "SearchSelectedView") { coder -> SearchSelectedViewController? in
            return SearchSelectedViewController(coder: coder, code: 2, genres: nil)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func navActorButton() {
        
    }
    
}
