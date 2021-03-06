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
    
    var searchController: UISearchController!
    let loggedUser = AppDelegate.shared.getUser()
    var realm: Realm!
    var searchList: [User]?
    var users: Results<User> {
        get {
            return realm.objects(User.self)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showAlert(message: "Você pode arrastar as células para o lado para ter mais opções (:", title: "Dica")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Setup
    
    override func setupView() {
        super.setupView()
        
        self.title = "Usuários cadastrados"
        
        do {
            realm = try Realm()
        } catch let error {
            handleDefaultError(error)
        }
        
        searchList = Array(users)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    //MARK: - Methods
    
    func confirmActionDelete(_ user: User) {
        guard let name = user.name else {
            handleDefaultError(NSError())
            return
        }
        
        showAlertWithCancel(message: "Deseja realmente excluir o usuário \(name)?", okHandler: { _ in
            self.deleteUser(user)
        }, cancelHandler: { _ in
            self.dismiss(animated: true, completion: nil)
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
            self.searchList = Array(self.users)
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
        guard let names = searchList else {return 0}
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let usr = searchList else {return UITableViewCell()}
        
        cell.textLabel?.text = usr[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let user = loggedUser, let name = user.name else {return ""}
        return "Olá, \(name)!"
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Deletar") { action, index in
            guard let usr = self.searchList else {return}
            self.confirmActionDelete(usr[index.row])
        }
        delete.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { action, index in
            guard let usr = self.searchList else {return}
            self.editUserInfo(usr[index.row])
        }
        edit.backgroundColor = .blue
        
        return [delete, edit]
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension UsuariosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchUser = searchController.searchBar.text {
            searchList = searchUser.isEmpty ? Array(users).map{$0} : Array(users).map{$0}.filter({(userName: User) -> Bool in
                guard let name = userName.name else {return false}
                return name.range(of: searchUser, options: .caseInsensitive) != nil
            })
            
            tableView.reloadData()
        }
    }
}

extension UsuariosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let txt = searchBar.text else {return true}
        return txt.count <= 50
    }
}
