//
//  Alert.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/04/23.
//

import Foundation
import UIKit

class Alert {
    
    static func showAlert<T: UIViewController>(on viewController: T, withTitle title: String?, message: String?, actions: [UIAlertAction]?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        } else {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
