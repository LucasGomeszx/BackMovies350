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
        configItems()
        configTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
    }
    
    private func configItems() {
        guard let items = tabBar.items else {return}
        items[0].title = "Filmes em cartaz"
        items[1].title = "Busca"
        items[2].title = "Favoritos"
        items[3].title = "Perfil"
        
        items[0].image = UIImage(systemName:"list.dash")
        items[1].image = UIImage(systemName:"magnifyingglass")
        items[2].image = UIImage(systemName:"heart")
        items[3].image = UIImage(systemName:"person.circle")
    }
    
    private func configTabBar(){
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.7)

    }
    
    func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
    }

}
