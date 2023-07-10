//
//  InfoViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/07/23.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var appLogoImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var tmdbInfo: UILabel!
    @IBOutlet weak var tmdbImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .infoBack
        appLogoImage.layer.cornerRadius = 25
        appName.textColor = .white
        appName.text = "BackMovies"
        tmdbInfo.textColor = .textColor
        tmdbInfo.text = "This product uses the TMDB API but is not endorsed or certified by TMDB."
        tmdbInfo.textAlignment = .center
        tmdbInfo.numberOfLines = 0
    }
    
}
