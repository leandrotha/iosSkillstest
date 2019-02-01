//
//  CadastroViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 30/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit
import RealmSwift

class CadastroViewController: BaseViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    //MARK: - Properties
    
    var shouldSuper: Bool = false
    var userToEdit: User?
    var realm: Realm!
    var users: Results<User>? {
        get {
            return realm.objects(User.self)
        }
    }

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cadastro"
        setupView()
    }
    
    //MARK: - View setup
    
    override func setupView() {
        if shouldSuper {
            super.setupView()
        }
        
        tfPassword.isSecureTextEntry = true
        tfEmail.keyboardType = .emailAddress
        
        btnRegister.layer.cornerRadius = 4.0
        btnRegister.layer.borderWidth = 1.0
        btnRegister.layer.borderColor = UIColor.black.cgColor
        
        if let _ = userToEdit {
            tfEmail.isHidden = true
            btnRegister.setTitle("Alterar", for: .normal)
            self.title = "Editar"
        }
        
        do {
            realm = try Realm()
        } catch let error {
            handleDefaultError(error)
        }
    }
    
    //MARK: - Methods
    
    func isValidUserInfo(_ email: String) -> Bool {
        if let users = self.users, !users.isEmpty {
            return users.filter{$0.email == email}.count == 0
        }
        
        return true
    }
    
    func initializeEditing(user: User) {
        self.userToEdit = user
    }
    
    func editUser(_ user: User) {
        guard let usr = userToEdit, let email = usr.email else {
            handleDefaultError(NSError())
            return
        }
        
        let editingUser = realm.objects(User.self).filter("email = %@", email)
        
        if let first = editingUser.first {
            do {
                try realm.write {
                    first.name = user.name ?? ""
                    first.password = user.password ?? ""
                    
                    showAlert(message: "Usuário atualizado com sucesso!", okHandler: { _ in
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    self.view.reloadInputViews()
                }
            } catch let error {
                handleDefaultError(error)
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func onClickCadastrar(_ sender: Any) {
        let user = User()
        
        if let name = tfName.text, name.isEmpty {
            tfName.invalidate()
            showAlert(message: "O campo nome é obrigatório!")
            
            return
        }
        
        tfName.validate()
        
        if let email = tfEmail.text, !tfEmail.isHidden {
            if email.isEmpty {
                tfEmail.invalidate()
                tfEmail.layer.borderColor = UIColor.red.cgColor
                showAlert(message: "O campo email é obrigatório!")
                
                return
            }
            
            if !email.isValidEmail() {
                tfEmail.invalidate()
                showAlert(message: "O emaiil informado é inválido!")
                
                return
            }
            
            if !isValidUserInfo(email) {
                showAlert(message: "Já existe um usuário cadastrado para este email!")
                
                return
            }
        }
        
        tfEmail.validate()
        
        if let password = tfPassword.text, password.isEmpty {
            tfPassword.invalidate()
            showAlert(message: "O campo senha é obrigatório!")
            
            return
        }
        
        tfPassword.validate()
        
        user.name = tfName.text?.trim()
        user.password = tfPassword.text
        user.email = tfEmail.text?.trim()
        
        if let _ = userToEdit {
            self.editUser(user)
            return
        }
        
        do {
            try realm.write {
                realm.add(user)
            }
        } catch let error {
            handleDefaultError(error)
            return
        }
        
        showAlert(message: "Usuário cadastrado com sucesso!", okHandler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
    }

}
