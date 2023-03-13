//
//  PosterViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class PosterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
    }
    
    func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }
}
