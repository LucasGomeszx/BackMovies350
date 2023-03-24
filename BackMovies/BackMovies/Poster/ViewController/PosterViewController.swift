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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
        setUpView()
        configTableView()
    }
    
    
    //MARK: - SetUps
    
    private func setUpView() {
        mainView.backgroundColor = .black
        titleLabel.textColor = .white
        posterTableView.backgroundColor = UIColor(displayP3Red: 50, green: 50, blue: 50, alpha: 1)
    }
    
    private func configTableView() {
        posterTableView.delegate = self
        posterTableView.dataSource = self
        posterTableView.register(PosterTableViewCell.nib(), forCellReuseIdentifier: PosterTableViewCell.identifier)
        posterTableView.backgroundColor = .black
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
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 2150
    }
    
}
