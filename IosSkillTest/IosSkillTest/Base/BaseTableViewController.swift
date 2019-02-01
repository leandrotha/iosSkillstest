//
//  BaseTableViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    //MARK: - Properties
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = "FAFAFA".hexToColor()
        
        setupView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //MARK: - Methods
    
    func setupView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: .logout)
    }
    
    func showSpinner() {
        DispatchQueue.main.async {
            self.spinner.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            self.spinner.hidesWhenStopped = true
            self.spinner.isHidden = false
            
            self.view.addSubview(self.spinner)
            
            self.spinner.startAnimating()
        }
    }
    
    func stopSpinner() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
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
    
    func showAlert(message: String, title: String? = "Atenção!" , okHandler: Action? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: okHandler ?? { action in
            self.dismiss(animated: true, completion: nil)
            })
        
        alert.addAction(action)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func handleDefaultError(_ error: Error) {
        DispatchQueue.main.async {
            print(error.localizedDescription)
            self.showAlert(message: "Algo de errado aconteceu, por favor, tente novamente mais tarde ):")
        }
    }
    
    @objc func logout() {
        showAlertWithCancel(message: "Deseja mesmo sair?", okHandler: { _ in
            AppDelegate.shared.setUser(nil)
            self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        })
    }

}

fileprivate extension Selector {
    static let logout = #selector(BaseTableViewController.logout)
}
