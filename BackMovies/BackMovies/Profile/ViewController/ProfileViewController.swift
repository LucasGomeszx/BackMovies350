//
//  ProfileViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        imageToCircle()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
        
    }
    
    func imageToCircle() {
            profilePhoto.layer.borderWidth = 1
            profilePhoto.layer.masksToBounds = false
            profilePhoto.layer.borderColor = UIColor.black.cgColor
            profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
            profilePhoto.clipsToBounds = true
    }

    @IBAction func tappedExitButton(_ sender: Any) {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
}
