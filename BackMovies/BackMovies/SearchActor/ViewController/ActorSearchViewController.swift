//
//  ActorSearchViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/23.
//

import UIKit

class SearchActorViewController: UIViewController {

    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actorSearchBar: UISearchBar!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    var viewModel: SearchActorViewModel = SearchActorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
