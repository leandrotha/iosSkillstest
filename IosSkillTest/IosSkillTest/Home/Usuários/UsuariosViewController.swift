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
    
    let loggedUser = AppDelegate.shared.getUser()
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
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
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
    
    func deleteUser(_ user: User) {
        guard let currentUser = loggedUser else {
            handleDefaultError(NSError())
            return
        }
        
        if currentUser.email == user.email {
            showAlert(message: "Ops! Você não pode apagar um usuário logado!")
            return
        }
        
        guard let email = user.email else {
            handleDefaultError(NSError())
            return
        }
        
        let userToDelete = realm.objects(User.self).filter("email = %@", email)
        
        if let usr = userToDelete.first {
            do {
                try realm.write {
                    realm.delete(usr)
                }
            } catch let error {
                handleDefaultError(error)
            }
        }
        
        showAlert(message: "Usuário deletado com sucesso!", okHandler: { _ in
            self.tableView.reloadData()
        })
    }
    
    func editUserInfo(_ user: User) {
        let vc = CadastroViewController()
        vc.initializeEditing(user: user)
        
        navigationController?.pushViewController(vc, animated: true)
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
        cell.accessoryType = .disclosureIndicator
        
        if users[indexPath.row].email == loggedUser?.email {
            cell.textLabel?.textColor = .green
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Usuários cadastrados"
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Deletar") { action, index in
            self.deleteUser(self.users[index.row])
        }
        delete.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { action, index in
            self.editUserInfo(self.users[index.row])
        }
        edit.backgroundColor = .blue
        
        return [delete, edit]
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

fileprivate extension Selector {
    static let logout = #selector(UsuariosViewController.logout)
}
