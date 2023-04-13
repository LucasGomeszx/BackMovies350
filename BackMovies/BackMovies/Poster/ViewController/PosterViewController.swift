//
//  PosterViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class PosterViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var posterTableView: UITableView!
    
    //MARK: - LifeCycle
    
    var viewModel: PosterViewModel = PosterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
        setUpView()
        configTableView()
        viewModel.fetchMovies()
    }
    
    
    //MARK: - SetUps
    
    private func setUpView() {
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
    }
    
    private func configTableView() {
        posterTableView.delegate = self
        posterTableView.dataSource = self
        posterTableView.register(PosterTableViewCell.nib(), forCellReuseIdentifier: PosterTableViewCell.identifier)
        posterTableView.backgroundColor = .clear
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - TableView Delegate , DataSource

extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as? PosterTableViewCell
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 2150
    }
    
}

extension PosterViewController: PosterTableViewCellDelegate {
    func nav() {
        let vc: MovieDetailsViewController? = UIStoryboard(name: "MoviesDetailsView", bundle: nil).instantiateViewController(withIdentifier: "MoviesDetailsView") as? MovieDetailsViewController
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
}
