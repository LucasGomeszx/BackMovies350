//
//  TabBarViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 09/03/23.
//

import UIKit

class TabBarViewController: UITabBarController {

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
