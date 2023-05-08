//
//  TabBarViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 09/03/23.
//

import UIKit

enum TabBarStrings: String {
    case posterTitle = "Filmes em cartaz"
    case posterIcon = "cinema25"
    case searchTitle = "Busca"
    case searchIcon = "magnifyingglass"
    case favoriteTitle = "Favoritos"
    case favoriteIcon = "heart"
    case profileTitle = "Perfil"
    case profileIcon = "person.circle"
}

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configItems()
        configTabBar()
        configureNavigation()
    }
    
    private func configItems() {
        guard let items = tabBar.items else {return}
        items[0].title = TabBarStrings.posterTitle.rawValue
        items[1].title = TabBarStrings.searchTitle.rawValue
        items[2].title = TabBarStrings.favoriteTitle.rawValue
        items[3].title = TabBarStrings.profileTitle.rawValue
        
        items[0].image = UIImage(named: TabBarStrings.posterIcon.rawValue)
        items[1].image = UIImage(systemName: TabBarStrings.searchIcon.rawValue)
        items[2].image = UIImage(systemName: TabBarStrings.favoriteIcon.rawValue)
        items[3].image = UIImage(systemName: TabBarStrings.profileIcon.rawValue)
    }
    
    private func configTabBar(){
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.backgroundColor = .lineGray

    }
    
    func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

}
