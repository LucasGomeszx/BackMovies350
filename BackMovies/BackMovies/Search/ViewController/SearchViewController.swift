//
//  SearchViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureNavigation()
        configureTableView()
    }
    
    let list: [String] = ["Ação","Aventura","Cinema de arte","Chanchada","Comédia","Comédia de ação","Comédia de terror","Comédia dramática","Comédia","romântica","Dança","Documentário", "Drama"]
    
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

    private func navMovieDetail() {
        let vc: SearchSelectedViewController? = UIStoryboard(name: "SearchSelectedView", bundle: nil).instantiateViewController(withIdentifier: "SearchSelectedView") as? SearchSelectedViewController
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadTableViewCell.identifier, for: indexPath) as? HeadTableViewCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BodyTableViewCell.identifier, for: indexPath) as? BodyTableViewCell
            cell?.delegate = self
            cell?.setUpCell(nome: list)
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 220
        default:
            return 830
        }
    }
}

extension SearchViewController: BodyTableViewCellDelegate {
    func navSearchSelected() {
        navMovieDetail()
    }
}

extension SearchViewController: HeadTableViewCellDelegate {
    func navMovieButton() {
        navMovieDetail()
    }
    
    func navActorButton() {
        navMovieDetail()
    }
    
    
}
