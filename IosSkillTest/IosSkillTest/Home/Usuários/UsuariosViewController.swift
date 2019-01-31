//
//  UsuariosViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit
import RealmSwift

class UsuariosViewController: BaseTableViewController {
    
    //MARK: - Properties
    
    var realm: Realm!
    var users: Results<User> {
        get {
            return realm.objects(User.self)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    //MARK: - Setup
    
    func setupView() {
        let userName = AppDelegate.shared.getUser()?.name
        
        self.title = "Olá, \(userName ?? "Bem-vindo!")"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: .logout)
        
        do {
            realm = try Realm()
        } catch let error {
            handleDefaultError(error)
        }
    }
    
    //MARK: - Methods
    
    @objc func logout() {
        showAlertWithCancel(message: "Deseja mesmo sair?", okHandler: { _ in
            AppDelegate.shared.setUser(nil)
            self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Usuários cadastrados"
    }
    
}

fileprivate extension Selector {
    static let logout = #selector(UsuariosViewController.logout)
}
