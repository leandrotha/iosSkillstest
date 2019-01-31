//
//  UsuariosViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

class UsuariosViewController: BaseTableViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    //MARK: - Setup
    
    func setupView() {
        self.title = "Usuários"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: .logout)
    }
    
    //MARK: - Methods
    
    @objc func logout() {
        AppDelegate.shared.setUser(nil)
        view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}

fileprivate extension Selector {
    static let logout = #selector(UsuariosViewController.logout)
}
