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
    
    var poster: Poster
    
    init(poster: Poster){
        self.poster = poster
        super.init(nibName: nil, bundle: nil)
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTopTableViewCell.identifier, for: indexPath) as? MovieTopTableViewCell
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrailerTableViewCell.identifier, for: indexPath) as? TrailerTableViewCell
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WatchTableViewCell.identifier, for: indexPath) as? WatchTableViewCell
            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActorTableViewCell.identifier, for: indexPath) as? ActorTableViewCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: RetatedTableViewCell.identifier, for: indexPath) as? RetatedTableViewCell
            cell?.delegate = self
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
            return 523
        case 1:
            return 460
        case 2:
            return 220
        case 3:
            return 250
        case 4:
            return 270
        case 5:
            return 240
        default:
            return 0
        }
    }
    
}

//MARK: - ActorTableViewCellDelegate

extension MovieDetailsViewController: ActorTableViewCellDelegate {
    func navActorDetail() {
        let vc: ActorDetailViewController? = UIStoryboard(name: "ActorDetailView", bundle: nil).instantiateViewController(withIdentifier: "ActorDetailView") as? ActorDetailViewController
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
}

//MARK: - ActorTableViewCellDelegate

extension MovieDetailsViewController: RetatedTableViewCellDelegate {
    func navRelatedMovies() {
        let vc: MovieDetailsViewController? = UIStoryboard(name: "MoviesDetailsView", bundle: nil).instantiateViewController(withIdentifier: "MoviesDetailsView") as? MovieDetailsViewController
        navigationController?.pushViewController(vc ?? UINavigationController(), animated: true)
    }
}
