//
//  ActorDetailViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

enum ActorDetailSection: Int {
    case ActorTopCell
    case ActorInfoCell
    case ActorMoviesCell
}

class ActorDetailViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var actorTitleLabel: UILabel!
    @IBOutlet weak var actorTableView: UITableView!
    
    var viewModel: ActorDetailsViewModel
    
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
        configureTableView()
        viewModel.setUpDelegate(delegate: self)
        viewModel.fetchActor()
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
        actorTableView.separatorStyle = .none
        actorTableView.allowsSelection = false
        actorTableView.register(ActorTopTableViewCell.nib(), forCellReuseIdentifier: ActorTopTableViewCell.identifier)
        actorTableView.register(ActorInfoTableViewCell.nib(), forCellReuseIdentifier: ActorInfoTableViewCell.identifier)
        actorTableView.register(ActorMoviesTableViewCell.nib(), forCellReuseIdentifier: ActorMoviesTableViewCell.identifier)
    }
    
    
    @IBAction func tappedBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
            return cell ?? UITableViewCell()
        case .ActorMoviesCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorMoviesTableViewCell.identifier, for: indexPath) as? ActorMoviesTableViewCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ActorDetailSection(rawValue: indexPath.row) {
        case .ActorTopCell:
            return viewModel.getActorTopCell
        case .ActorInfoCell:
            return viewModel.getActorInfoCell
        case .ActorMoviesCell:
            return viewModel.getActorMoviesCell
        default:
            return 0
        }
    }
    
}

extension ActorDetailViewController: ActorMoviesTableViewCellDelegate {
    func navActorMovies() {
        let vc: MovieDetailsViewController? = UIStoryboard(name: "MoviesDetailsView", bundle: nil).instantiateViewController(withIdentifier: "MoviesDetailsView") as? MovieDetailsViewController
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
}

extension ActorDetailViewController: ActorDetailsViewModelDelegate {
    func sim() {
        actorTableView.reloadData()
    }
    
    func nao() {
        
    }
    
}
