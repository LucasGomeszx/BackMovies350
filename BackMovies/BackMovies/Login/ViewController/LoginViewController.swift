//
//  ViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var googleImageView: UIImageView!
    
    @IBOutlet weak var appleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurandoLoginView()
    }

    func configurandoLoginView() {
        appleImageView.clipsToBounds = true
    }

}

