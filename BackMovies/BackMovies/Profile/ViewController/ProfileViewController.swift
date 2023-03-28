//
//  ProfileViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

protocol profileViewControllerProtocol: AnyObject {
    func backLoginScreen()
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    var delegate: profileViewControllerProtocol?
    
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
//        let someTabIndex = 0
//        let t = self.tabBarController
//        t?.selectedIndex = someTabIndex
//        let v = t?.viewControllers?[someTabIndex]
//        if let n = v?.navigationController {
//            n.popToRootViewController(animated: true)
//        }
        
        delegate?.backLoginScreen()
    }
    
}
