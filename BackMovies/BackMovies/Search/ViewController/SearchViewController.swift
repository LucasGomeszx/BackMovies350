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
    
    private func setUpView() {
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
        titleLabel.text = "Busca"
        searchTableView.backgroundColor = .lightGray
        searchTableView.layer.cornerRadius = 15
    }
    
    private func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
