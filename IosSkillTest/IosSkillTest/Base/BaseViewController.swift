//
//  BaseViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 30/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import Foundation
import UIKit

typealias Action = (UIAlertAction)->()

class BaseViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Methods
    
    func showAlert(message: String, title: String? = "Atenção!" , okHandler: Action? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: okHandler ?? { action in
                self.dismiss(animated: true, completion: nil)
            })
        
        alert.addAction(action)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func handleDefaultError(_ error: Error) {
        print(error.localizedDescription)
        showAlert(message: "Algo de errado aconteceu, por favor, tente novamente mais tarde ):")
    }
}
