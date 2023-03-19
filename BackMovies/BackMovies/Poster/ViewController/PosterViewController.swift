//
//  PosterViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class PosterViewController: UIViewController {
    
    @IBOutlet weak var posterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
        configTableView()
    }
    
    private func configTableView() {
        posterTableView.delegate = self
        posterTableView.dataSource = self
    }
    
    func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }
}

extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
