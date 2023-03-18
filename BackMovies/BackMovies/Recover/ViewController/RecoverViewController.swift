//
//  RecoverViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 09/03/23.
//

import UIKit

class RecoverViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupView()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
        
    }
    
    func setupView() {
        backButton.tintColor = .white
    }

    
    @IBAction func tappedBackButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

}
