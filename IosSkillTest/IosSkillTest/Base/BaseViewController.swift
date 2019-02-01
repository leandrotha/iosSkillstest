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
        
        view.backgroundColor = "FAFAFA".hexToColor()
        
        setupView()
    }
    
    //MARK: - Methods
    
    func setupView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: .logout)
    }
    
    func handleDefaultError(_ error: Error) {
        print(error.localizedDescription)
        showAlert(message: "Algo de errado aconteceu, por favor, tente novamente mais tarde ):")
    }
    
    func showAlert(message: String, title: String? = "Atenção!" , okHandler: Action? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: okHandler ?? { action in
                self.dismiss(animated: true, completion: nil)
            })
        
        alert.addAction(action)
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
    func showAlertWithCancel(message: String, title: String? = "Atenção!" , okHandler: Action? = nil, cancelHandler: Action? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: okHandler ?? { action in
            self.dismiss(animated: true, completion: nil)
            })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: cancelHandler ?? { action in
            self.dismiss(animated: true, completion: nil)
            })
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    @objc func logout() {
        showAlertWithCancel(message: "Deseja mesmo sair?", okHandler: { _ in
            AppDelegate.shared.setUser(nil)
            self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        })
    }
}

fileprivate extension Selector {
    static let logout = #selector(BaseViewController.logout)
}
