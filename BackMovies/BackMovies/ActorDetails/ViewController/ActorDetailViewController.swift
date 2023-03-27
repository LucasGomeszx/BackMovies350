//
//  ActorDetailViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class ActorDetailViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var actorTitleLabel: UILabel!
    @IBOutlet weak var actorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureTableView()
    }
    
    private func setUpView() {
        mainView.backgroundColor = .black
        actorTitleLabel.text = "Detalhes"
        actorTitleLabel.textColor = .white
        actorTableView.backgroundColor = UIColor(named: "BackGray")
        actorTableView.layer.cornerRadius = 15
    }
    
    private func configureTableView() {
        actorTableView.delegate = self
        actorTableView.dataSource = self
        actorTableView.register(ActorTopTableViewCell.nib(), forCellReuseIdentifier: ActorTopTableViewCell.identifier)
        actorTableView.register(ActorInfoTableViewCell.nib(), forCellReuseIdentifier: ActorInfoTableViewCell.identifier)
    }
    
}

//MARK: - TableViewDelegate, TableViewDataSource

extension ActorDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorTopTableViewCell.identifier, for: indexPath) as? ActorTopTableViewCell
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorInfoTableViewCell.identifier, for: indexPath) as? ActorInfoTableViewCell
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 750
        case 1:
            return 250
        default:
            return 0
        }
    }
    
}
