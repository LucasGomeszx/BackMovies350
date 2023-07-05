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
    
    static func showAlertWithTextField<T: UIViewController>(on viewController: T, withTitle title: String?, message: String?, textFieldPlaceholder: String?, cancelTitle: String, saveTitle: String, cancelHandler: (() -> Void)? = nil, saveHandler: ((String?) -> Void)? = nil) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alertController.addTextField { textField in
                textField.placeholder = textFieldPlaceholder
            }
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alertController.addAction(cancelAction)
            
            let saveAction = UIAlertAction(title: saveTitle, style: .default) { _ in
                let text = alertController.textFields?.first?.text
                saveHandler?(text)
            }
            alertController.addAction(saveAction)
            
            viewController.present(alertController, animated: true, completion: nil)
        }
}

